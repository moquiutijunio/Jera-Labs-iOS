//
//  LabsDescriptionViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxCocoa

protocol LabsDescriptionViewProtocol: BaseViewProtocol {
    
}

class LabsDescriptionViewController: BaseViewController {
    
    var presenterProtocol: LabsDescriptionPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLogoOnNav()
        addRightBarButton(image: #imageLiteral(resourceName: "ic_info_outline").withRenderingMode(.alwaysTemplate)) {
            print("TODO Show about view")
        }
    }
}

extension LabsDescriptionViewController: LabsDescriptionViewProtocol {
    
}
