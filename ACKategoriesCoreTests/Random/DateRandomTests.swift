import XCTest
import Foundation

final class DateRandomTests: XCTestCase {
    func testDateIsInBoundsGiven() {
        DispatchQueue.concurrentPerform(iterations: 50) { _ in
            let randomDate = Date.random(min: 0, max: 1)
            let possibleDates = [Date(timeIntervalSince1970: 0), Date(timeIntervalSince1970: 1)]
            XCTAssertTrue(possibleDates.contains(randomDate))
        }
    }
    
    func testNumberOfDatesInCollectionAreInBoundsGiven() {
        DispatchQueue.concurrentPerform(iterations: 50) { _ in
            let randomDates: [Date] = .random(min: 1, max: 2)
            XCTAssertTrue(1...2 ~= randomDates.count)
        }
    }
}
