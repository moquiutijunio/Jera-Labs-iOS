//
//  WebViewPreseter.swift
//  Labs
//
//  Created by Junio Moquiuti on 06/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol WebViewPresenterProtocol {
    func webViewDidFinishLoad()
    func webViewDidStartLoad()
    func webViewDidFailLoadWithError(error: Error)
    
    var currentURL: Variable<URL> {get}
}

class WebViewPresenter: BasePresenter {
    
    weak var viewProtocol: WebViewProtocol?
    weak var router: WebViewWireFrameProtocol?
    var webViewFinishLoading: Bool = false
    
    let currentURL: Variable<URL>
    
    init(currentURL: URL) {
        self.currentURL = Variable(currentURL)
    }
}

extension WebViewPresenter: WebViewPresenterProtocol {
    
    func webViewDidStartLoad() {
        viewProtocol?.placeholder(type: .loading(text: R.string.localizable.alertLoading()), buttonAction: nil)
    }
    
    func webViewDidFinishLoad() {
        viewProtocol?.hidePlaceholder()
    }
    
    func webViewDidFailLoadWithError(error: Error) {
//        Crashlytics.sharedInstance().recordError(error)
        
        viewProtocol?.placeholder(type: .error(text: error.localizedDescription, buttonText: R.string.localizable.alertTryAgain()), buttonAction: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewProtocol?.reloadWebView(url: strongSelf.currentURL.value)
        })
    }
}
