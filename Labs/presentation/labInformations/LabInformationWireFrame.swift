//
//  LabInformationWireFrame.swift
//  Labs
//
//  Created by Junio Moquiuti on 01/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxCocoa

protocol LabInformationWireFrameProtocol: class {
    func showWebViewWith(url: URL, title: String)
    func showAppleStoreWith(url: URL, title: String)
}

class LabInformationWireFrame: BaseWireFrame {
    
    private var navigationController: UINavigationController?
    let viewController: LabInformationViewController

    let presenter: LabInformationPresenterProtocol
    
    init(lab: Lab) {
        let presenter = LabInformationPresenter(lab: lab)

        self.viewController = LabInformationViewController(nibName: "LabInformationViewController", bundle: nil)
        self.presenter = presenter
        
        super.init()

        viewController.presenter = presenter
        presenter.viewProtocol = viewController
        presenter.router = self
        
        self.callback = callback
    }
    
    func presentOn(navigationController: UINavigationController, callback: WireFrameCallbackProtocol) {
        navigationController.pushViewController(viewController, animated: true)
        
        self.navigationController = navigationController
        self.callback = callback
        
        _ = self.navigationController!.rx
            .didShow
            .takeUntil(rx.deallocated)
            .subscribe(onNext: { [weak self] (viewController, _) in
                guard let strongSelf = self else { return }
                
                if strongSelf.viewController === viewController {
                    strongSelf.presentedWireFrame = nil
                }
            })
    }
}

extension LabInformationWireFrame: LabInformationWireFrameProtocol {
    
    func showWebViewWith(url: URL, title: String) {
        guard let navigationController = navigationController else { return }
        let webViewWireFrame = WebViewWireFrame(url: url, title: title, callback: self)
        webViewWireFrame.presentOn(navigationController: navigationController)
        presentedWireFrame = webViewWireFrame
    }
    
    func showAppleStoreWith(url: URL, title: String) {
        guard UIApplication.shared.canOpenURL(url) else {
            showWebViewWith(url: url, title: title)
            return
        }
        
        UIApplication.shared.openURL(url)
    }
}
