//
//  Appearance.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

extension UIColor {
    static var primaryColor: UIColor { return UIColor(red: 99/255, green: 194/255, blue: 95/255, alpha:1) }
//    static var primaryColor: UIColor { UIColor(red:0.2, green:0.77, blue:0.37, alpha:1) }
    static var separetorColor: UIColor { return UIColor(red:0.22, green:0.22, blue:0.21, alpha:1.0) }
}

struct Appearance {

    static func applyUIAppearence() {
        UINavigationBar.appearance().tintColor = .gray
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.primaryColor]
        
        UIActivityIndicatorView.appearance().color = .primaryColor
    }
}
