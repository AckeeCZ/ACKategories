//
//  UIStackViewTests.swift
//  ACKategories
//
//  Created by Jakub Olejník on 13/06/2018.
//  Copyright © 2018 Ackee, s.r.o. All rights reserved.
//

import XCTest
import ACKategories

final class UIStackViewTests: XCTestCase {
    
    func testViewsAreRemoved() {
        let views = (0..<10).map { _ in UIView() }
        let stack = UIStackView(arrangedSubviews: views)
        
        XCTAssertEqual(views.count, stack.arrangedSubviews.count)
        
        views.forEach { XCTAssertEqual(stack, $0.superview) }
        
        stack.removeAllArrangedSubviews()
        
        XCTAssertEqual(0, stack.arrangedSubviews.count)
        views.forEach { XCTAssertNil($0.superview) }
    }
    
}
