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
        
        if keychainStatus == errSecItemNotFound && isUserDefaultsEmpty() && !fileExists() {
            //On a fresh install, store an item into the keychain and user defaults
            //treat this scenario as an error (it can only happen once)
            setInitialData()
            viewController.status = [.firstInstall]
            
        } else {
            
            if isUserDefaultsEmpty() {
                viewController.status.append(.userDefaultsError)
            }
            
            if keychainStatus != errSecSuccess {
                viewController.status.append(.keychainError(keychainStatus))
            }
            
            if !fileExists() {
                viewController.status.append(.fileError)
            }

        }
        
        return true
    }
    
    func setInitialData() {
        //User Defaults initial key
        UserDefaults.standard.set("notFirstInstall", forKey: "firstInstall")
        
        //Keychain initial key
        let query : [String : Any] = [
            kSecAttrService as String : "keychain_service",
            kSecAttrAccount as String : "keychain_account",
            kSecValueData as String : demoData,
            kSecClass as String : kSecClassGenericPassword
        ]
        let status : OSStatus = SecItemAdd(query as CFDictionary, nil);
        print(status)
        
        //Store initial file
        FileManager.default.createFile(atPath: filePath, contents: demoData, attributes: [ FileAttributeKey.protectionKey.rawValue : FileProtectionType.none])
    }

    
    // Check if user defauls contains the 'firstInstall' key
    func isUserDefaultsEmpty() -> Bool {
        let firstInstall = UserDefaults.standard.string(forKey: "firstInstall")
        return firstInstall == nil
    }
  
    
    // Retrieve Keychain item and return the keychain error code
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
    
    
    // Check a file in Documents Folder
    func fileExists() -> Bool {
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    // Helper methods
    var filePath : String {
        let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        return directory! + "/firstInstallFile"
    }
    
    var demoData : Data {
        return "notFirstInstall".data(using: String.Encoding.utf8)!
    }
    
}

