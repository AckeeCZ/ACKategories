//
//  ColorTests.swift
//  ACKategories
//
//  Created by Jan Mísař on 31.08.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import ACKategories

final class ColorTests: XCTestCase {
    func testLightColorRecognition() {
        var color = UIColor(hex: 0xffffff)
        
        XCTAssertTrue(color.isLight)
        
        color = UIColor(hex: 0xf6ff00)
        XCTAssertTrue(color.isLight)
        
        color = UIColor(hex: 0x70ffd5)
        XCTAssertTrue(color.isLight)
    }
    
    func testDarkColorRecognition() {
        var color = UIColor(hex: 0x000000)
        XCTAssertTrue(color.isDark)
        
        color = UIColor(hex: 0x16765a)
        XCTAssertTrue(color.isDark)
        
        color = UIColor(hex: 0x502f52)
        XCTAssertTrue(color.isDark)
    }
}
