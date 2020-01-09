//
//  ArrayTests.swift
//  UnitTests
//
//  Created by Jakub Olejník on 05/09/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import XCTest
import ACKategoriesCore

final class ArrayTests: XCTestCase {
    func testSafeSubscriptReturnsCorrectObject() {
        let range = 0..<10
        let array = range.map { $0 }
        
        range.forEach {
            XCTAssertEqual($0, array[safe: $0])
        }
    }
    
    func testSafeSubscriptReturnsNilIfIndexOverBounds() {
        let range = 0..<10
        let array = range.map { $0 }
        
        range.forEach {
            XCTAssertNil(array[safe: $0 + range.count])
        }
    }
    
    func testSafeSubscriptReturnsNilIfIndexNegative() {
        let range = 0..<10
        let array = range.map { $0 }
        
        range.forEach {
            XCTAssertNil(array[safe: -$0 - 1])
        }
    }
    
    func testSafeRangeSubscriptReturnsCorrectObjects() {
        let range1 = 0..<10
        let range2 = 5..<15
        let resultRange = range2.lowerBound..<range1.upperBound
        let array = range1.map { $0 }
        
        resultRange.forEach {
            XCTAssertEqual($0, array[safe: range2][$0 - resultRange.count])
        }
    }
    
    func testSafeRangeSubscriptReturnsAllForOverlapingRange() {
        let range1 = 0..<10
        let range2 = 0..<15
        let array = range1.map { $0 }
        
        XCTAssertEqual(array, array[safe: range2])
    }
}
