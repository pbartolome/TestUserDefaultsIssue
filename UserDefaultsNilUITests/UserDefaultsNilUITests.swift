//
//  UserDefaultsNilUITests.swift
//  UserDefaultsNilUITests
//
//  Created by Pablo Bartolome on 10/20/16.
//  Copyright © 2016 PB. All rights reserved.
//

import XCTest

class UserDefaultsNilUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
    }
    
    func testLoopLaunchApp() {
        var iteration = 0
        while true {
            XCUIApplication().launch()
            let app = XCUIApplication()
            let oklabelExists = app.staticTexts["OK!"].exists
            
            if iteration == 0 && !oklabelExists {
                print("First iteration, correct first install detected")
            } else if oklabelExists {
                print("Correct not first install detected in iteration \(iteration)")
            } else {
                XCTFail("Error: User defaults is empty in iteration \(iteration)")
            }
            
            iteration += 1
        }
    }
    
}
