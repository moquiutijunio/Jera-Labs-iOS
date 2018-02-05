//
//  LabsDescriptionWireFrame.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol LabsDescriptionWireFrameProtocol: class {
    func openLabInformation(_ lab: Lab)
    func previewViewControllerFor(lab: Lab) -> UIViewController
    func finishPreviewingViewController()
    func openAboutApp()
}

class LabsDescriptionWireFrame: BaseWireFrame {
    
    let navigationController: UINavigationController
    let viewController = LabsDescriptionViewController()
    let presenter: LabsDescriptionPresenterProtocol
    let interactor: LabsDescriptionInteractorProtocol
    var labInformationWireFramePreviewing: LabInformationWireFrame?
    
    override init() {
        let interactor = LabsDescriptionInteractor()
        let presenter = LabsDescriptionPresenter()
        
        self.presenter = presenter
        self.interactor = interactor
        
        viewController.presenter = presenter
        interactor.repository = LabsDescriptionRepository(firebaseRealtimeDatabase: FirebaseRealtimeDatabase())
        
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

extension LabsDescriptionWireFrame: LabsDescriptionWireFrameProtocol {
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
