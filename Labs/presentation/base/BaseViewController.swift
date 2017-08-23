//
//  BaseViewController.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol BaseViewProtocol {
    
}

class BaseViewController: BaseViewProtocol {
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}
