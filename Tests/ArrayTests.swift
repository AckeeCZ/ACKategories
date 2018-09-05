//
//  ArrayTests.swift
//  UnitTests
//
//  Created by Jakub Olejník on 05/09/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import XCTest
import ACKategories

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
}
