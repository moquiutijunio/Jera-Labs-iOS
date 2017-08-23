//
//  LabsDescriptionViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol LabsDescriptionViewProtocol: class {
    
}

class LabsDescriptionViewController: BaseViewController {
    
    var presenterProtocol: LabsDescriptionPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension LabsDescriptionViewController: LabsDescriptionViewProtocol {
    
}
