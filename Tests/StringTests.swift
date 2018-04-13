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
    
    func testStringMatchesRegex() {
        let string = "aBc037"
        let regex = "([a-zA-Z]+)([0-9])+"
        
        XCTAssertTrue(string.matchesRegex(regex))
    }
    
    func testStringIsNumeric() {
        let string = "1234567890"
        XCTAssertTrue(string.isNumeric)
    }
    
    func testStringIsNotNumeric() {
        let string = "1234567890a"
        XCTAssertFalse(string.isNumeric)
    }
    
    func testStringIsPadded() {
        let string = "abc"
        let paddedString = string.leftPadding(toLength: 5, withPad: "0")
        XCTAssertEqual("00abc", paddedString)
    }
    
    func testPaddingIsRemoved() {
        let paddedString = "00abc"
        let string = paddedString.removeLeftPadding(pad: "0")
        XCTAssertEqual(string, "abc")
    }
}
