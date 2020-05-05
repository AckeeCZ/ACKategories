import XCTest
import Foundation

final class StringRandomTests: XCTestCase {
    func testRandomStringContainsOnlyAllowedLetters() {
        DispatchQueue.concurrentPerform(iterations: 50) { _ in
            let randomString = String.random(allowedCharacters: "ad")
            XCTAssertTrue(randomString.allSatisfy("ad".contains))
        }
    }
    
    func testLengthOfStringIsSmallerThanGivenValue() {
        DispatchQueue.concurrentPerform(iterations: 50) { _ in
            let randomString = String.random(minLength: 0, maxLength: 2)
            XCTAssertTrue(0...2 ~= randomString.count)
        }
    }
    
    func testNumberOfStringsInCollectionAreInBoundsGiven() {
        DispatchQueue.concurrentPerform(iterations: 50) { _ in
            let randomStrings: [String] = .random(min: 1, max: 2)
            XCTAssertTrue(1...2 ~= randomStrings.count)
        }
    }
}
