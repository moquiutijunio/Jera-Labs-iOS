//
//  DomainHelper.swift
//  Labs
//
//  Created by Junio Moquiuti on 26/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

extension UIColor {
    static var primaryColor: UIColor { return UIColor(red: 99/255, green: 194/255, blue: 95/255, alpha:1) }
    static var separetorColor: UIColor { return UIColor(red:0.22, green:0.22, blue:0.21, alpha:1.0) }
}

extension UIButton {
    func setTitleWithoutAnimation(_ title: String?, for state: UIControlState) {
        UIView.performWithoutAnimation { [weak self] in
            self?.setTitle(title, for: state)
            self?.layoutIfNeeded()
        }
    }
}
