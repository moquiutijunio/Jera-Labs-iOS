//
//  Appearance.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

struct Appearance {
    static let primaryColor = UIColor(red: 99/255, green: 194/255, blue: 95/255, alpha:1)
    
    static func applyUIAppearence() {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Appearance.primaryColor]
        
        UIActivityIndicatorView.appearance().color = Appearance.primaryColor
    }
}
