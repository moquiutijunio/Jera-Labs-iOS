//
//  Appearance.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

struct Appearance {

    static func applyUIAppearence() {
        UINavigationBar.appearance().tintColor = .primaryColor
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.primaryColor]
        
        UIActivityIndicatorView.appearance().color = .primaryColor
    }
}
