//
//  FoundationTests.swift
//  ACKategories
//
//  Created by Tomas Holka on 29/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import ACKategories

class FoundationSpec: QuickSpec {
    override func spec() {
        describe("Dictionary") {
            
            it("counts correctly") {
                let dict: [String:Any?] = ["key":1, "key2":"value2", "key3":nil]
                let dictWithoutNils = dict.nilsRemoved
                
                expect(dict.count) == 3
                expect(dictWithoutNils.count) == 2
            }
        }
        
        
        describe("Optional") {
            
            it("checks if string is empty") {
                
                let string1: String? = "test"
                let string2: String? = nil
                let string3: String? = ""
                
                expect(string1.isEmpty) == false
                expect(string2.isEmpty) == true
                expect(string3.isEmpty) == true
            }
        }
    }
}
