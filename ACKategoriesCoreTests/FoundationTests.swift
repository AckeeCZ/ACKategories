//
//  FoundationTests.swift
//  ACKategories
//
//  Created by Tomas Holka on 29/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import ACKategoriesCore

final class FoundationTests: XCTestCase {
    
    func testThatDictionaryCountsCorrectly() {
        let dict: [String: Any?] = ["key": 1, "key2": "value2", "key3": nil]
        let dictWithoutNils = dict.nilsRemoved
        
        XCTAssertEqual(3, dict.count)
        XCTAssertEqual(2, dictWithoutNils.count)
    }
    
    func testThatDictionaryGetsCorrectValue() {
        let dict: [String: Any?] = ["key": 1, "key2": ["key3": 3.17]]
        let value1: Int = dict.value(for: "key")!
        let value2: Double = dict.value(for: "key2.key3")!
        
        XCTAssertEqual(value1, 1)
        XCTAssertEqual(value2, 3.17)
    }
    
    func testThatOptionalChecksIfStringIsEmpty() {
        let string1: String? = "test"
        let string2: String? = nil
        let string3: String? = ""
        
        XCTAssertFalse(string1.isEmpty)
        XCTAssertTrue(string2.isEmpty)
        XCTAssertTrue(string3.isEmpty)
    }
    
    func testThatOptionalChecksIfArrayIsEmpty() {
        let array1: [Int]? = [1, 2, 3]
        let array2: [Int]? = nil
        let array3: [Int]? = []
        
        XCTAssertFalse(array1.isEmpty)
        XCTAssertTrue(array2.isEmpty)
        XCTAssertTrue(array3.isEmpty)
    }
    
    func testThatNumberFormatterConvertsIntToString() {
        let numberFormatter = NumberFormatter()
        let integer = 10
        let numberString = numberFormatter.string(from: integer)
        
        XCTAssertEqual("10", numberString)
    }
    
    func testThatDictionariesAreMerged() {
        let dict1 = ["a": "b"]
        let dict2 = ["b": "a"]
        
        XCTAssertEqual(dict1 + dict2, ["a": "b", "b": "a"])
    }
    
    func testThatObjectIsRemovedFromArray() {
        var array = [1, 2, 3, 5]
        
        array.remove(object: 2)
        
        XCTAssertEqual([1, 3, 5], array)
    }
}
