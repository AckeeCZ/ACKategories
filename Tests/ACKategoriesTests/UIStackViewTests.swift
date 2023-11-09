#if canImport(UIKit) && !os(watchOS)
import XCTest
import ACKategories
import UIKit

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
#endif
