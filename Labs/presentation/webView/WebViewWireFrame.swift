//
//  WebViewWireFrame.swift
//  Labs
//
//  Created by Junio Moquiuti on 06/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol WebViewWireFrameProtocol: PresenterWireFrameProtocol {
    
}

class WebViewWireFrame: BaseWireFrame {
    
    var navigationController: UINavigationController?
    let viewController = WebViewController(nibName: "WebViewController", bundle: nil)
    
    let presenter: WebViewPresenterProtocol
    
    init(url: URL, title: String, presenterWireFrame: PresenterWireFrameProtocol) {
        let presenter = WebViewPresenter(currentURL: url)
        
        self.presenter = presenter
        
        viewController.presenterProtocol = presenter
        viewController.title = title
        
        super.init()
        
        presenter.viewProtocol = viewController
        presenter.router = self
        
        self.presenterWireFrame = presenterWireFrame
    }
    
    func presentOn(navigationController: UINavigationController) {
        navigationController.pushViewController(viewController, animated: true)
        self.navigationController = navigationController
        
        _ = self.navigationController!.rx
            .didShowViewController
            .takeUntil(rx.deallocated)
            .subscribe(onNext: { [weak self] (viewController) in
                guard let strongSelf = self else { return }
                
                if strongSelf.viewController.isEqual(viewController) {
                    strongSelf.presentedWireFrame = nil
                }
            })
    }
}

extension WebViewWireFrame: WebViewWireFrameProtocol {
    
}
