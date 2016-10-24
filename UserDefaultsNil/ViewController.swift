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
    case fileError
    case keychainError(OSStatus)
    
    var value : String {
        switch self {
        case .noError:
            return "OK!"
        case .firstInstall:
            return "FIRST INSTALL"
        case .fileError:
            return "FILE ERROR"
        case .userDefaultsError:
            return "USER DEFAULTS ERROR"
        case .keychainError(let status):
            return "KEYCHAIN ERROR STATUS \(status)"
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label : UILabel!
    
    //Use an array in case there are more than one failure
    var status : [StatusType] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        label.accessibilityIdentifier = "statusLabel"
        
        if status.count > 0 {
            for error in status {
                label.text = error.value + "\n" + label.text!
            }
            
            switch status.first! {
            case .firstInstall:
                view.backgroundColor = UIColor.yellow
            default:
                view.backgroundColor = UIColor.red
            }
            
        } else {
            label.text = StatusType.noError.value
            view.backgroundColor = UIColor.green
        }

        

    }

}

