//
//  AppDelegate.swift
//  UserDefaultsNil
//
//  Created by Pablo Bartolome on 10/20/16.
//  Copyright © 2016 PB. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if isFirstInstall() {
            UserDefaults.standard.set("notFirstInstall", forKey: "firstInstall")
            let viewController = self.window?.rootViewController as! ViewController
            viewController.isFirstInstall = true
        }
        
        return true
    }

    func isFirstInstall() -> Bool {
        return UserDefaults.standard.string(forKey: "firstInstall") != nil
    }
  

}

