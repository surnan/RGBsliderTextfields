//
//  AppDelegate.swift
//  rgbSliderGUI
//
//  Created by admin on 1/24/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //below needed after deleting storyboard
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
        //above needed after deleting storyboard
        
        return true
    }
}
