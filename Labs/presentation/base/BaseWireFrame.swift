//
//  BaseWireFrame.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol WireFrameCallbackProtocol: class {
    func shouldDismissPresentedWireFrame()
}

class BaseWireFrame: NSObject {
    var presentedWireFrame: BaseWireFrame?
    weak var callback: WireFrameCallbackProtocol?
    
    internal var disposeBag = DisposeBag()
    
    override init() {
        super.init()
        bind()
    }
    
    internal func bind() {
        
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension BaseWireFrame: WireFrameCallbackProtocol {
    
    func shouldDismissPresentedWireFrame() {
        presentedWireFrame = nil
    }
}
