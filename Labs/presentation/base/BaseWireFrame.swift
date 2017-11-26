//
//  BaseWireFrame.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol PresentedWireFrameInterface {
    
}

protocol PresenterWireFrameProtocol: class {
    func wireframeDidDismiss()
}

class BaseWireFrame: NSObject {
    
    var presentedWireFrame: PresentedWireFrameInterface?
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

extension BaseWireFrame: PresentedWireFrameInterface {
    
}
