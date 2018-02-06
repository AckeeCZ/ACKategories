//
//  FoundationTests.swift
//  ACKategories
//
//  Created by Tomas Holka on 29/06/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

//import Foundation
//import Quick
//import Nimble
//import ACKategories
//
//class FoundationSpec: QuickSpec {
//    override func spec() {
//        describe("Dictionary") {
//            
//            it("counts correctly") {
//                let dict: [String:Any?] = ["key":1, "key2":"value2", "key3":nil]
//                let dictWithoutNils = dict.nilsRemoved
//                
//                expect(dict.count) == 3
//                expect(dictWithoutNils.count) == 2
//            }
//            
//            
//            it("gets correct value") {
//                let dict: [String:Any?] = ["key":1, "key2":["key3":3.17]]
//                let value1: Int = dict.value(for: "key")!
//                let value2: Double = dict.value(for: "key2.key3")!
//
//                expect(value1) == 1
//                expect(value2) == 3.17
//            }
//        }
//        
//        
//        describe("Optional") {
//            
//            it("checks if string is empty") {
//                
//                let string1: String? = "test"
//                let string2: String? = nil
//                let string3: String? = ""
//                
//                expect(string1.isEmpty) == false
//                expect(string2.isEmpty) == true
//                expect(string3.isEmpty) == true
//            }
//            
//            it("checks if array is empty") {
//                
//                let array1: [Int]? = [1, 2, 3]
//                let array2: [Int]? = nil
//                let array3: [Int]? = []
//                
//                expect(array1.isEmpty) == false
//                expect(array2.isEmpty) == true
//                expect(array3.isEmpty) == true
//            }
//        }
//        
//        
//        describe("NumberFormatter") {
//            
//            it("converts int to string") {
//                let numberFormatter = NumberFormatter()
//                let integer = 10
//                let numberString = numberFormatter.string(from: integer)
//                
//                expect(numberString) == "10"
//            }
//        }
//    }
//}

