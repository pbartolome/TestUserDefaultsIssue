//
//  UserDefaultsNilTests.swift
//  UserDefaultsNilTests
//
//  Created by Pablo Bartolome on 10/20/16.
//  Copyright © 2016 PB. All rights reserved.
//

import XCTest
@testable import UserDefaultsNil

class UserDefaultsNilTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.set("test", forKey: "testKey")
    }
    
    
    func testInfiniteUserDefaults() {
        var i = 0
        while (UserDefaults.standard.string(forKey: "testKey") != nil) {
            print("\(i): user defaults not nil")
            i += 1
        }
        XCTFail("user defaults nil")
    }
}
