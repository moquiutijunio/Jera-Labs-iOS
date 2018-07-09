//
//  LabsDescriptionWireFrame.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol LabsWireFrameProtocol: class {
    func showLabInformation(with lab: Lab)
    func showPreviewLabInformationFor(lab: Lab) -> UIViewController
    func finishPreviewingLabInformation()
    func showAbout()
}

class LabsWireFrame: BaseWireFrame {
    
    private let navigationController: UINavigationController
    private let viewController: LabsViewController
    private let presenter: LabsPresenterProtocol
    private let interactor: LabsInteractorProtocol
    private var labInformationWireFramePreviewing: LabInformationWireFrame?
    
    override init() {
        interactor = LabsInteractor(repository: LabsRepository(firebaseRealtimeDatabase: FirebaseRealtimeDatabase()))
        let presenter = LabsPresenter(interactor: interactor)
        
        self.viewController = LabsViewController()
        self.presenter = presenter
        
        navigationController = UINavigationController(rootViewController: viewController)
        
        super.init()

        viewController.presenter = presenter
        presenter.viewProtocol = viewController
        presenter.interactor = interactor
        presenter.router = self
    }
    
    func present(window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
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
}

extension LabsWireFrame: LabsWireFrameProtocol {
    func showLabInformation(with lab: Lab) {
        let labInformationWireFrame = LabInformationWireFrame(lab: lab)
        labInformationWireFrame.presentOn(navigationController: navigationController, callback: self)
        presentedWireFrame = labInformationWireFrame
    }
    
    func showPreviewLabInformationFor(lab: Lab) -> UIViewController {
        let labInformationWireFrame = LabInformationWireFrame(lab: lab)
        labInformationWireFramePreviewing = labInformationWireFrame
        return labInformationWireFrame.viewController
    }
    
    func finishPreviewingLabInformation() {
        guard let labInformationWireFramePreviewing = labInformationWireFramePreviewing else { return }
        labInformationWireFramePreviewing.presentOn(navigationController: navigationController, callback: self)
        self.presentedWireFrame = labInformationWireFramePreviewing
        self.labInformationWireFramePreviewing = nil
    }
    
    func showAbout() {
        let aboutWireFrame = AboutWireFrame(callback: self)
        aboutWireFrame.presentOn(viewController: viewController)
        presentedWireFrame = aboutWireFrame
    }
}
