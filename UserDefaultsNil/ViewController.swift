//
//  ViewController.swift
//  UserDefaultsNil
//
//  Created by Pablo Bartolome on 10/20/16.
//  Copyright © 2016 PB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label : UILabel!
    var isFirstInstall : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Test"
        
        if isFirstInstall {
            view.backgroundColor = UIColor.red
            label.text = "First Install"
        } else {
            view.backgroundColor = UIColor.green
            label.text = "OK!"
        }
    }

}

