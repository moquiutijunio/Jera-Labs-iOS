//
//  WebViewViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 06/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol WebViewProtocol: BaseViewProtocol {
    func reloadWebView(url: URL)
}

class WebViewController: BaseViewController {
    
    @IBOutlet fileprivate weak var webView: UIWebView!
    
    private var presenterDisposeBag: DisposeBag!
    var presenter: WebViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        applyLayout()
        bind()
    }
    
    private func applyLayout() {
        webView.delegate = self
        webView.backgroundColor = .white
    }
    
    private func bind() {
        presenterDisposeBag = DisposeBag()
        
        presenter.currentURL
            .asObservable()
            .subscribe(onNext: { [weak self] (currentURL) in
                guard let strongSelf = self else { return }
                
                strongSelf.webView.loadRequest(URLRequest(url: currentURL))
                strongSelf.presenter?.webViewDidStartLoad()
            })
            .disposed(by: presenterDisposeBag)
    }
}

extension WebViewController: WebViewProtocol {
    func reloadWebView(url: URL) {
        webView.loadRequest(URLRequest(url: url))
        presenter?.webViewDidStartLoad()
    }
}

extension WebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        presenter?.webViewDidFinishLoad()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        presenter?.webViewDidStartLoad()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        presenter?.webViewDidFailLoadWithError(error: error)
    }
}
