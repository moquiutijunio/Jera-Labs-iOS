//
//  AboutWireFrame.swift
//  Labs
//
//  Created by Junio Moquiuti on 16/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol AboutWireFrameProtocol: class {
    func dismiss()
}

class AboutWireFrame: BaseWireFrame {
    
    var navigationController: UINavigationController?
    let viewController = AboutViewController(nibName: "AboutViewController", bundle: nil)
    let presenter: AboutPresenterProtocol
    let interactor: AboutInteractorProtocol
    
    init(presenterWireFrame: PresenterWireFrameProtocol) {
        let presenter = AboutPresenter()
        let interactor = AboutInteractor()
        
        self.presenter = presenter
        self.interactor = interactor
        
        viewController.presenter = presenter
        interactor.repository = AboutRepository(firebaseRealtimeDatabase: FirebaseRealtimeDatabase())
        
        navigationController = UINavigationController(rootViewController: viewController)
        
        super.init()
        
        presenter.viewProtocol = viewController
        presenter.interactor = interactor
        presenter.router = self
        self.presenterWireFrame = presenterWireFrame
    }
    
    func presentOn(viewController: UIViewController) {
        guard let navigationController = navigationController else { return }
        viewController.present(navigationController, animated: true, completion: nil)
        
        _ = navigationController.rx
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

extension AboutWireFrame: AboutWireFrameProtocol {
    func dismiss() {
        viewController.dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.presenterWireFrame?.wireframeDidDismiss()
        }
    }
}
