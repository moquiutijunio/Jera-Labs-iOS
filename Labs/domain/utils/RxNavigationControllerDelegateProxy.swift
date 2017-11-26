//
//  RxNavigationControllerDelegateProxy.swift
//  Labs
//
//  Created by Junio Moquiuti on 01/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UINavigationController {
    
    /// Factory method that enables subclasses to implement their own `delegate`.
    ///
    /// - returns: Instance of delegate proxy that wraps `delegate`.
    func creatRxDelegateProxy() -> RxNavigationControllerDelegateProxy {
        return RxNavigationControllerDelegateProxy(parentObject: self)
    }
    
}
extension Reactive where Base: UINavigationController {
    
    /// Reactive wrapper for `delegate`.
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    var delegate: DelegateProxy {
        return RxNavigationControllerDelegateProxy.proxyForObject(base)
    }
    
    /// Reactive wrapper for `delegate` message.
    public var didShowViewController: Observable<UIViewController> {
        return delegate
            .methodInvoked(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
            .map { params in
                return params[1] as! UIViewController
        }
    }
}
/// For more information take a look at `DelegateProxyType`.
public class RxNavigationControllerDelegateProxy: DelegateProxy, UINavigationControllerDelegate, DelegateProxyType {
    
    /// For more information take a look at `DelegateProxyType`.
    public class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let navigationController: UINavigationController = object as! UINavigationController
        return navigationController.delegate
    }
    
    /// For more information take a look at `DelegateProxyType`.
    public class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let navigationController: UINavigationController = object as! UINavigationController
        navigationController.delegate = delegate as? UINavigationControllerDelegate
    }
    
    // MARK: Delegate proxy methods
    
    /// For more information take a look at `DelegateProxyType`.
    public override class func createProxyForObject(_ object: AnyObject) -> AnyObject {
        let navigationController: UINavigationController = object as! UINavigationController
        return navigationController.creatRxDelegateProxy()
    }
    
}
