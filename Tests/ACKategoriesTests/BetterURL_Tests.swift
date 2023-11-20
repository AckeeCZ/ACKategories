import ACKategories
import XCTest

final class BetterURL_Tests: XCTestCase {
    /// Tests URLs that are valid according to specs therefore should not be modified in any way
    func test_validURL() throws {
        let urls = [
            "https://ackee.cz/some%20thing",
            "https://ackee.cz/something",
        ]
        
        XCTAssertFalse(urls.isEmpty)
        
        try urls.forEach { url in
            let subject = try XCTUnwrap(BetterURL(rawValue: url))
            XCTAssertEqual(subject.url.absoluteString, subject.rawValue)
            XCTAssertEqual(subject.url.absoluteString, url)
        }
    }
    
    func test_additionalEscaping() throws {
        let urlsWithExpectedResults = [
            (raw: "https://ackee.cz/image .jpg", expected: "https://ackee.cz/image%20.jpg"),
            (
                raw: "https://ackee.cz/{WIDTH}/{HEIGHT}/image.jpg",
                expected: "https://ackee.cz/%7BWIDTH%7D/%7BHEIGHT%7D/image.jpg"
            ),
        ]
        
        XCTAssertFalse(urlsWithExpectedResults.isEmpty)
        
        try urlsWithExpectedResults.forEach { url, expected in
            let subject = try XCTUnwrap(BetterURL(rawValue: url))
            
            XCTAssertEqual(subject.rawValue, url)
            XCTAssertEqual(subject.url.absoluteString, expected)
        }
    }

    func test_codable() throws {
        let betterURL = try XCTUnwrap(BetterURL(rawValue: "https://ackee.cz/{WIDTH}/{HEIGHT}/image.jpg"))
        let jsonData = try JSONEncoder().encode(betterURL)
        let decodedBetterURL = try JSONDecoder().decode(BetterURL.self, from: jsonData)

        XCTAssertEqual(decodedBetterURL, betterURL)
    }
    
    func test_rawRepresentable() throws {
        let rawValue = "https://ackee.cz/{WIDTH}/{HEIGHT}/image.jpg"
        let subject = try XCTUnwrap(BetterURL(rawValue: rawValue))
        XCTAssertEqual(rawValue, subject.rawValue)
    }
}
