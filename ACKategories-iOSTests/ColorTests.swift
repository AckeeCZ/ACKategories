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
    
    func testBasicColorsToHex() {
        var hexColor: String?
        
        let clearColor = UIColor.clear
        hexColor = clearColor.hexString
        XCTAssertEqual("#000000", hexColor)
        
        let blackColor = UIColor.black
        hexColor = blackColor.hexString
        XCTAssertEqual("#000000", hexColor)
        
        let whiteColor = UIColor.white
        hexColor = whiteColor.hexString
        XCTAssertEqual("#FFFFFF", hexColor)
        
        let greenColor = UIColor.green
        hexColor = greenColor.hexString
        XCTAssertEqual("#00FF00", hexColor)
    }
    
    func testP3RedColorToHex() {
        if #available(iOS 10, *) {
            let p3redColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1)
            let hexColor = p3redColor.hexString
            XCTAssertEqual("#000000", hexColor)
        }
    }
    
    func testPatternImageColorToHex() {
        let image = UIColor.green.image()
        let patternImageColor = UIColor(patternImage: image)
        let hexColor = patternImageColor.hexString
        XCTAssertEqual(nil, hexColor)
    }
    
    func testColorWithGrayscaleToHex() {
        let white = UIColor(white: 1, alpha: 1)
        let hexColor = white.hexString
        XCTAssertEqual("#FFFFFF", hexColor)
    }

    func testRGBColorToHex() {
        let rgb = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        let hexColor = rgb.hexString
        XCTAssertEqual("#00FF00", hexColor)
    }
    
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
