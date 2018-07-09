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
    
    private let navigationController: UINavigationController
    private let viewController: AboutViewController
    private let presenter: AboutPresenterProtocol
    private let interactor: AboutInteractorProtocol
    
    init(callback: WireFrameCallbackProtocol) {
        interactor = AboutInteractor(repository: AboutRepository(firebaseRealtimeDatabase: FirebaseRealtimeDatabase()))
        
        let presenter = AboutPresenter()
        
        self.viewController = AboutViewController(nibName: "AboutViewController", bundle: nil)
        self.presenter = presenter
        
        navigationController = UINavigationController(rootViewController: viewController)
        
        super.init()
        
        viewController.presenter = presenter
        presenter.viewProtocol = viewController
        presenter.interactor = interactor
        presenter.router = self
        
        self.callback = callback
    }
    
    override func bind() {
        super.bind()
        
        _ = navigationController.rx
            .didShow
            .takeUntil(rx.deallocated)
            .subscribe(onNext: { [weak self] (viewController, _) in
                guard let strongSelf = self else { return }
                
                if strongSelf.viewController === viewController {
                    strongSelf.presentedWireFrame = nil
                }
            })
    }
    
    func presentOn(viewController: UIViewController) {
        viewController.present(navigationController, animated: true, completion: nil)
    }
    
}

extension AboutWireFrame: AboutWireFrameProtocol {
    
    func dismiss() {
        viewController.dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.callback?.shouldDismissPresentedWireFrame()
        }
    }
}
