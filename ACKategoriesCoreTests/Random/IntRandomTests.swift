import XCTest
import Foundation

final class IntRandomTests: XCTestCase {
    func testIntIsInBoundsGiven() {
        DispatchQueue.concurrentPerform(iterations: 50) { _ in
            let randomInt = Int.random(min: 0, max: 1)
            XCTAssertTrue(0...1 ~= randomInt)
        }
    }
    
    func testNumberOfIntsInCollectionAreInBoundsGiven() {
        DispatchQueue.concurrentPerform(iterations: 50) { _ in
            let randomInts: [Int] = .random(min: 1, max: 2)
            XCTAssertTrue(1...2 ~= randomInts.count)
        }
    }
}
