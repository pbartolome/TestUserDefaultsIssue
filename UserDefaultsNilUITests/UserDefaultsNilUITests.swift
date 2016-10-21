//
//  UserDefaultsNilUITests.swift
//  UserDefaultsNilUITests
//
//  Created by Pablo Bartolome on 10/20/16.
//  Copyright © 2016 PB. All rights reserved.
//

import XCTest

class UserDefaultsNilUITests: XCTestCase {
    
    func testLoopLaunchApp() {
        var iteration = 0
        while true {
            //prevent xcode from killing the ui test because the app is not ready
            //"Busy ("Application is installing or uninstalling, and cannot be launched")"
            sleep(2)
            
            XCUIApplication().launch()
            let app = XCUIApplication()
            
            if iteration == 0 && app.staticTexts["FIRST INSTALL"].exists {
                print("First iteration, correct first install detected")
            } else if app.staticTexts["OK!"].exists {
                print("Correct not first install detected in iteration \(iteration)")
            } else {
                let error = app.staticTexts.element(matching: .any, identifier: "statusLabel").label
                XCTFail("Error: \(error) in iteration \(iteration)")
            }
            
            iteration += 1
        }
    }
    
}
