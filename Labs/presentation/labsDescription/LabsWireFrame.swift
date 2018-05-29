//
//  LabsDescriptionWireFrame.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol LabsWireFrameProtocol: class {
    func openLabInformation(_ lab: Lab)
    func previewViewControllerFor(lab: Lab) -> UIViewController
    func finishPreviewingViewController()
    func openAboutApp()
}

class LabsWireFrame: BaseWireFrame {
    
    let navigationController: UINavigationController
    let viewController = LabsViewController()
    let presenter: LabsPresenterProtocol
    let interactor: LabsInteractorProtocol
    var labInformationWireFramePreviewing: LabInformationWireFrame?
    
    override init() {
        let interactor = LabsInteractor()
        let presenter = LabsPresenter()
        
        self.presenter = presenter
        self.interactor = interactor
        
        viewController.presenter = presenter
        interactor.repository = LabsRepository(firebaseRealtimeDatabase: FirebaseRealtimeDatabase())
        
        navigationController = UINavigationController(rootViewController: viewController)
        
        super.init()
        
        presenter.viewProtocol = viewController
        presenter.interactor = interactor
        presenter.router = self
        
        self.presenterWireFrame = self
    }
    
    func present(window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension LabsWireFrame: LabsWireFrameProtocol {
    func openLabInformation(_ lab: Lab) {
        let labInformationWireFrame = LabInformationWireFrame(lab: lab)
        labInformationWireFrame.presentOn(navigationController: navigationController, presenterWireFrame: self)
        presentedWireFrame = labInformationWireFrame
    }
    
    func previewViewControllerFor(lab: Lab) -> UIViewController {
        let labInformationWireFrame = LabInformationWireFrame(lab: lab)
        labInformationWireFramePreviewing = labInformationWireFrame
        return labInformationWireFrame.viewController
    }
    
    func finishPreviewingViewController() {
        guard let labInformationWireFramePreviewing = labInformationWireFramePreviewing else { return }
        labInformationWireFramePreviewing.presentOn(navigationController: navigationController, presenterWireFrame: self)
        self.presentedWireFrame = labInformationWireFramePreviewing
        self.labInformationWireFramePreviewing = nil
    }
    
    func openAboutApp() {
        let aboutWireFrame = AboutWireFrame(presenterWireFrame: self)
        aboutWireFrame.presentOn(viewController: viewController)
        presentedWireFrame = aboutWireFrame
    }
}
