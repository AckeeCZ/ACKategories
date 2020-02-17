//
//  UIViewTests.swift
//  UnitTests
//
//  Created by Jakub Olejník on 14/06/2019.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import UIKit
import XCTest
import ACKategories

final class UIViewTests: XCTestCase {
    func testForceIntrinsic() {
        let view = UIView()
        let dummyPriority = UILayoutPriority(rawValue: 10)
        view.setContentCompressionResistancePriority(dummyPriority, for: .vertical)
        view.setContentCompressionResistancePriority(dummyPriority, for: .horizontal)
        view.setContentHuggingPriority(dummyPriority, for: .vertical)
        view.setContentHuggingPriority(dummyPriority, for: .horizontal)
        
        view.forceIntrinsic()
        
        XCTAssertEqual(view.contentHuggingPriority(for: .vertical), .required)
        XCTAssertEqual(view.contentHuggingPriority(for: .horizontal), .required)
        XCTAssertEqual(view.contentCompressionResistancePriority(for: .horizontal), .required)
        XCTAssertEqual(view.contentCompressionResistancePriority(for: .vertical), .required)
    }
}
