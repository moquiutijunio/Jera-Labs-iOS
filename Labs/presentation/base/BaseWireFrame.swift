//
//  BaseWireFrame.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol PresenterWireFrameProtocol: class {
    func wireframeDidDismiss()
}

class BaseWireFrame: NSObject {
    
    var presentedWireFrame: BaseWireFrame?
    weak var presenterWireFrame: PresenterWireFrameProtocol?
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension BaseWireFrame: PresenterWireFrameProtocol {
    
    func wireframeDidDismiss() {
        presentedWireFrame = nil
    }
}
