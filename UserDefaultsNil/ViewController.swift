//
//  ViewController.swift
//  UserDefaultsNil
//
//  Created by Pablo Bartolome on 10/20/16.
//  Copyright © 2016 PB. All rights reserved.
//

import UIKit

enum StatusType {
    case noError
    case firstInstall
    case userDefaultsError
    case keychainError(OSStatus)
    
    var value : String {
        switch self {
        case .noError:
            return "OK!"
        case .firstInstall:
            return "FIRST INSTALL"
        case .userDefaultsError:
            return "USER DEFAULTS ERROR"
        case .keychainError(let status):
            return "KEYCHAIN ERROR STATUS \(status)"
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label : UILabel!
    
    var status : StatusType = .noError

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch status {
        case .noError:
            view.backgroundColor = UIColor.green
        case .firstInstall:
            view.backgroundColor = UIColor.yellow
        default:
            view.backgroundColor = UIColor.red
        }
        
        label.text = status.value
        label.accessibilityIdentifier = "statusLabel"
    }

}

