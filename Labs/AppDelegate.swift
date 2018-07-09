//
//  AppDelegate.swift
//  Labs
//
//  Created by Junio Moquiuti on 20/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var labsWireFrame: LabsWireFrame?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        Fabric.with([Crashlytics.self])
        FirebaseApp.configure()
        
        Appearance.applyUIAppearence()
        
        let window = UIWindow()
        window.frame = UIScreen.main.bounds
        labsWireFrame = LabsWireFrame()
        labsWireFrame?.present(window: window)
        self.window = window
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}
