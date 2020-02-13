//
//  DateFormattingTests.swift
//  ACKategories-Example
//
//  Created by Jan Misar on 02.08.18.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import XCTest
import ACKategoriesCore

final class DateFormattingTests: XCTestCase {
    
    func testCachedDateFormatterWorks() {
        let date = Date()
        
        let df1 = DateFormatter.cached(for: "DDMMYYYY")
        
        let df2 = DateFormatter()
        df2.setLocalizedDateFormatFromTemplate("DDMMYYYY")
        
        XCTAssertEqual(df1.string(from: date), df2.string(from: date))
    }
    
    func testCachedDateFormatter() {
        let df1 = DateFormatter.cached(for: "DDMMYYYY")
        let df2 = DateFormatter.cached(for: "DDMMYYYY")
        
        XCTAssertEqual(df1, df2)
    }
}
