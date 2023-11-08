import ACKategories
import SwiftUI
import XCTest

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
}
