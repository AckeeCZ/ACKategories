import ACKategories
import SwiftUI
import XCTest

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
final class EdgeInsetsTests: XCTestCase {
    func test_init_size() {
        XCTAssertEqual(
            EdgeInsets(10),
            .init(
                top: 10,
                leading: 10,
                bottom: 10,
                trailing: 10
            )
        )
    }
    
    func test_zero() {
        XCTAssertEqual(
            EdgeInsets.zero,
            .init(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 0
            )
        )
    }
}
