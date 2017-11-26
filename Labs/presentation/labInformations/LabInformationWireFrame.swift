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
    func openWebViewWith(url: URL, title: String)
}

class LabInformationWireFrame: BaseWireFrame {
    
    var navigationController: UINavigationController?
    let viewController = LabInformationViewController(nibName: "LabInformationViewController", bundle: nil)

    let presenter: LabInformationPresenterProtocol
    
    init(lab: Lab) {
        let presenter = LabInformationPresenter(lab: lab)

        self.presenter = presenter
        
        viewController.presenterProtocol = presenter
        
        super.init()

        presenter.viewProtocol = viewController
        presenter.router = self
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

extension LabInformationWireFrame: LabInformationWireFrameProtocol {
    func openWebViewWith(url: URL, title: String) {
        guard let navigationController = navigationController else { return }
        let webViewWireFrame = WebViewWireFrame(url: url, title: title)
        webViewWireFrame.presentOn(navigationController: navigationController)
        presentedWireFrame = webViewWireFrame
    }
}
