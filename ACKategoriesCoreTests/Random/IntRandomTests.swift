import XCTest
import Foundation

final class IntRandomTests: XCTestCase {    
    func testNumberOfIntsInCollectionAreInBoundsGiven() {
        DispatchQueue.concurrentPerform(iterations: 50) { _ in
            let randomInts: [Int] = .random(min: 1, max: 2)
            XCTAssertTrue(1...2 ~= randomInts.count)
        }
    }
}
