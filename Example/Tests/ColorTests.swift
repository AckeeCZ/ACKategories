//
//  ColorTests.swift
//  ACKategories
//
//  Created by Jan Mísař on 31.08.16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import ACKategories

class ColorSpec: QuickSpec {
    override func spec() {
        describe("Color") {
            it("recognizes light colors") {
                var color = UIColor(hex: 0xffffff)
                expect(color.isLight) == true

                color = UIColor(hex: 0xf6ff00)
                expect(color.isLight) == true

                color = UIColor(hex: 0x70ffd5)
                expect(color.isLight) == true
            }

            it("recognizes dark colors") {
                var color = UIColor(hex: 0x000000)
                expect(color.isDark) == true

                color = UIColor(hex: 0x16765a)
                expect(color.isDark) == true

                color = UIColor(hex: 0x502f52)
                expect(color.isDark) == true
            }
        }
    }
}
