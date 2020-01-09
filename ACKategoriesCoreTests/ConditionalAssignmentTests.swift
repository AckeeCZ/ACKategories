//
//  ConditionalAssignmentTests.swift
//  UnitTests
//
//  Created by Jakub Olejník on 06/02/2018.
//  Copyright © 2018 Josef Dolezal. All rights reserved.
//

import XCTest
import ACKategoriesCore

final class ConditionalAssignmentTests: XCTestCase {
    
    func testValueIsSetIfNotNil() {
        var oldValue = "a"
        let newValue: String? = "b"
        
        oldValue =? newValue
        
        XCTAssertEqual(oldValue, newValue)
    }
    
    func testValueIsIgnoredIfNil() {
        var oldValue = "a"
        let newValue: String? = nil
        
        oldValue =? newValue
        
        XCTAssertEqual(oldValue, "a")
    }
    
    func testVariableIsOptionalValueIsIgnoredIfNil() {
        var oldValue: String? = "a"
        let newValue: String? = nil
        
        oldValue =? newValue
        
        XCTAssertEqual(oldValue, "a")
    }
    
    func testVariableIsOptionalValueIsSetIfNotNil() {
        var oldValue: String? = "a"
        let newValue: String? = "b"
        
        oldValue =? newValue
        
        XCTAssertEqual(oldValue, newValue)
    }
}
