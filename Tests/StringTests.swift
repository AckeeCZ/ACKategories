//
//  StringTests.swift
//  ACKategories
//
//  Created by Jakub Olejník on 06/09/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import ACKategories

final class StringTests: XCTestCase {
    func testStringReadsFirstLetter() {
        let string = "String"
        
        XCTAssertEqual(string.firstLetter, "S")
        XCTAssertNotEqual(string.firstLetter, "s")
    }
    
    func testStringTrimms() {
        let string = "     String\nString\n\n\n"
        
        XCTAssertEqual(string.trimmed(), "String\nString")
    }
    
    func testStringNormalizes() {
        let string = "ěščřžýáíéüä"
        
        XCTAssertEqual(string.normalized(), "escrzyaieua")
    }
}
