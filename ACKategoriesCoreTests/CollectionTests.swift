//
//  CollectionTests.swift
//  UnitTests
//
//  Created by Marek Fořt on 2/4/19.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import XCTest
import ACKategoriesCore

final class CollectionTests: XCTestCase {

    func testNonEmpty() {
        var array: [Int]? = nil

        XCTAssertNil(array.nonEmpty)

        array = []
        XCTAssertNil(array.nonEmpty)

        array = [1]
        XCTAssertNotNil(array.nonEmpty)
    }

    func testIsNotEmptyOptional() {
        var array: [Int]? = nil

        XCTAssertFalse(array.isNotEmpty)

        array = []
        XCTAssertFalse(array.isNotEmpty)

        array = [1]
        XCTAssertTrue(array.isNotEmpty)
    }

    func testIsNotEmpty() {
        var array: [Int] = []

        XCTAssertFalse(array.isNotEmpty)

        array = [1]
        XCTAssertTrue(array.isNotEmpty)
    }

}
