//
//  BaseInteractor.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import Foundation

class BaseInteractor: NSObject {
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}
