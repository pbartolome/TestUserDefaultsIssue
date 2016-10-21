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
        
        let viewController = self.window?.rootViewController as! ViewController
        let keychainStatus = self.keychainStatus()
        
        
        if keychainStatus == errSecItemNotFound && isUserDefaultsEmpty() {
            //On a fresh install, store an item into the keychain and user defaults
            //but treat this scenario as an error (it can only happen once)

            //User Defaults initial key
            UserDefaults.standard.set("notFirstInstall", forKey: "firstInstall")
            
            //Keychain initial key
            if keychainStatus == errSecItemNotFound {
                let query : [String : Any] = [
                    kSecAttrService as String : "keychain_service",
                    kSecAttrAccount as String : "keychain_account",
                    kSecValueData as String : "notFirstInstall".data(using: String.Encoding.utf8)!,
                    kSecClass as String : kSecClassGenericPassword
                ]
                let status : OSStatus = SecItemAdd(query as CFDictionary, nil);
                print(status)
            }
            
            viewController.status = .firstInstall
        } else if isUserDefaultsEmpty() {
            viewController.status = .userDefaultsError
        } else if keychainStatus != errSecSuccess {
            viewController.status = .keychainError(keychainStatus)
        }
        
        return true
    }

    func isUserDefaultsEmpty() -> Bool {
        let fisrtInstall = UserDefaults.standard.string(forKey: "firstInstall")
        return fisrtInstall == nil
    }
  
    func keychainStatus() -> OSStatus {
        let query : [String : Any] = [
            kSecReturnAttributes as String : kCFBooleanTrue,
            kSecMatchLimit as String : kSecMatchLimitAll,
            kSecClass as String : kSecClassGenericPassword
        ]
        var data: AnyObject?
        let status : OSStatus = SecItemCopyMatching(query as CFDictionary, &data);
        return status
    }

}

