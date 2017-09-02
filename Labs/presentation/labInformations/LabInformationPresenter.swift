//
//  LabInformationPresenter.swift
//  Labs
//
//  Created by Junio Moquiuti on 01/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol LabInformationPresenterProtocol {
    
}

class LabInformationPresenter: BasePresenter {
    
    weak var viewProtocol: LabInformationViewProtocol?
    weak var router: LabInformationWireFrameProtocol?

}

extension LabInformationPresenter: LabInformationPresenterProtocol {
    
}

