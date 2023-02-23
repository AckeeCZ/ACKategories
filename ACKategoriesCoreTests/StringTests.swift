//
//  StringTests.swift
//  ACKategories
//
//  Created by Jakub Olejník on 06/09/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import ACKategoriesCore

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
    
    func testLeadingPaddingIsRemoved() {
        let paddedString = "00abc"
        let string = paddedString.trimmed(charactersIn: "0", from: .leading)
        XCTAssertEqual(string, "abc")
    }
    
    func testTrailingPaddingIsRemoved() {
        let paddedString = "abc00"
        let string = paddedString.trimmed(charactersIn: "0", from: .trailing)
        XCTAssertEqual(string, "abc")
    }
    
    func testPaddingIsRemoved() {
        let paddedString = "00a00bc00"
        let string = paddedString.trimmed(charactersIn: "0", from: .both)
        XCTAssertEqual(string, "a00bc")
    }
    
    func testJustLeadingPaddingIsRemoved() {
        let paddedString = "00a00bc00"
        let string = paddedString.trimmed(charactersIn: "0", from: .leading)
        XCTAssertEqual(string, "a00bc00")
    }
    
    func testJustTrailingPaddingIsRemoved() {
        let paddedString = "00a00bc00"
        let string = paddedString.trimmed(charactersIn: "0", from: .trailing)
        XCTAssertEqual(string, "00a00bc")
    }
    
    func testStringPaddingIsRemoved() {
        let paddedString = "xyxya00bcxy"
        let string = paddedString.trimmed(charactersIn: "xy0", from: .both)
        XCTAssertEqual(string, "a00bc")
    }
    
    func testDiacriticIsRemoved() {
        let originalString = "ěščřžýáíéasdfghjkl"
        XCTAssertEqual(originalString.removingDiacritics(), "escrzyaieasdfghjkl")
    }

    func testValidURLWithWhitespace() throws {
        let urlStringWithWhitespace = "https://raw.githubusercontent.com/olejnjak/csas-transparent-accounts/url_test/image .jpg"
        let validURLWithWhitespace = BetterURL(rawValue: urlStringWithWhitespace)
        let unwrappedURL = try XCTUnwrap(validURLWithWhitespace, "Url should not be nil")
        
        XCTAssertEqual(unwrappedURL.url.absoluteString, "https://raw.githubusercontent.com/olejnjak/csas-transparent-accounts/url_test/image%20.jpg")
    }

    func testValidUrlWithSymbols() throws {
        let urlStringWithSymbols = "https://raw.githubusercontent.com/olejnjak/csas-transparent-accounts/url_test/{WIDTH}/{HEIGHT}/image.jpg"
        let validUrlWithSymbols = BetterURL(rawValue: urlStringWithSymbols)
        let unwrappedURL = try XCTUnwrap(validUrlWithSymbols, "Url should not be nil")

        XCTAssertEqual(unwrappedURL.url.absoluteString, "https://raw.githubusercontent.com/olejnjak/csas-transparent-accounts/url_test/%7BWIDTH%7D/%7BHEIGHT%7D/image.jpg")
    }

    func testValidUrlWithPercentageSymbol() throws {
        let urlStringWithPercentageSymbols = "https://google.com/some%20thing"
        let validUrlWithPercentageSymbols = BetterURL(rawValue: urlStringWithPercentageSymbols)
        let unwrappedURL = try XCTUnwrap(validUrlWithPercentageSymbols, "Url should not be nil")

        XCTAssertEqual(unwrappedURL.url.absoluteString, "https://google.com/some%20thing")
    }

    func testCodable() throws {
        let betterURL = BetterURL(rawValue: "https://raw.githubusercontent.com/olejnjak/csas-transparent-accounts/url_test/{WIDTH}/{HEIGHT}/image.jpg")
        let jsonData = try JSONEncoder().encode(betterURL)
        let decodedBetterURL = try? JSONDecoder().decode(BetterURL.self, from: jsonData)

        XCTAssertEqual(decodedBetterURL, betterURL)
    }
}
