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
        continueAfterFailure = false
        
    }
    
    func testLoopLaunchApp() {
        while true {
            XCUIApplication().launch()
            let app = XCUIApplication()
            let oklabel = app.staticTexts["ok!"].exists
            XCTAssertTrue(oklabel, "User defaults is empty")
        }
    }
    
}
