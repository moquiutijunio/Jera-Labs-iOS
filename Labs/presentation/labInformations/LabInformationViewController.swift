//
//  LabInformationViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 01/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxCocoa

protocol LabInformationViewProtocol: BaseViewProtocol {
    
}

class LabInformationViewController: BaseViewController {
    
    var presenterProtocol: LabInformationPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension LabInformationViewController: LabInformationViewProtocol {
    
}

extension LabInformationViewController {
    
}
