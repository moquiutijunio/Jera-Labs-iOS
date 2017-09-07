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
    
    init(url: URL, title: String) {
        let presenter = WebViewPresenter(currentURL: url)
        
        self.presenter = presenter
        
        viewController.presenterProtocol = presenter
        viewController.title = title
        
        super.init()
        
        presenter.viewProtocol = viewController
        presenter.router = self
    }
    
    func presentOn(navigationController: UINavigationController) {
        navigationController.pushViewController(viewController, animated: true)
        self.navigationController = navigationController
    }
}

extension WebViewWireFrame: WebViewWireFrameProtocol {
    
}
