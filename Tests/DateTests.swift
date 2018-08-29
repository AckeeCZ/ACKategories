//
//  DateTests.swift
//  ACKategories
//
//  Created by Jakub Olejník on 13/06/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import XCTest
import ACKategories

final class DateTests: XCTestCase {
    
    var date: Date!
    
    override func setUp() {
        super.setUp()
        
        date = Date()
    }
    
    func testCorrectSecond() {
        let df = DateFormatter()
        df.dateFormat = "s"
        
        XCTAssertEqual(Int(df.string(from: date)), date.second)
    }
    
    func testCorrectMinute() {
        let df = DateFormatter()
        df.dateFormat = "m"
        
        XCTAssertEqual(Int(df.string(from: date)), date.minute)
    }
    
    func testCorrectHour() {
        let df = DateFormatter()
        df.dateFormat = "H"
        
        XCTAssertEqual(Int(df.string(from: date)), date.hour)
    }
    
    func testCorrectDay() {
        let df = DateFormatter()
        df.dateFormat = "d"
        
        XCTAssertEqual(Int(df.string(from: date)), date.day)
    }
    
    func testCorrectMonth() {
        let df = DateFormatter()
        df.dateFormat = "M"
        
        XCTAssertEqual(Int(df.string(from: date)), date.month)
    }
    
    func testCorrectYear() {
        let df = DateFormatter()
        df.dateFormat = "YYYY"
        
        XCTAssertEqual(Int(df.string(from: date)), date.year)
    }
}
