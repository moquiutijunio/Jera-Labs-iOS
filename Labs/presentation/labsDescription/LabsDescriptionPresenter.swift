//
//  LabsDescriptionPresenter.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol LabsDescriptionPresenterProtocol {
    
}

class LabsDescriptionPresenter: BasePresenter {
    
    weak var viewProtocol: LabsDescriptionViewProtocol?
    weak var router: LabsDescriptionWireFrameProtocol?
    fileprivate var interactor: LabsDescriptionInteractorProtocol
    
    init(interactor: LabsDescriptionInteractorProtocol) {
        self.interactor = interactor
    }
}

extension LabsDescriptionPresenter: LabsDescriptionPresenterProtocol {
    
}
