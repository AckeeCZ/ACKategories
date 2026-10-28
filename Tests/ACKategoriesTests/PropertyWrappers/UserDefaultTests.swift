import Combine
import Foundation
import XCTest
import ACKategories

final class UserDefaultTests: XCTestCase {
    private var subject: MyUserDefaultProvider!
    private var userDefaults: UserDefaults!
    private var decoder: JSONDecoder!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        decoder = JSONDecoder()
        userDefaults = UserDefaults(suiteName: "my_user_default")
        subject = MyUserDefaultProvider()
        cancellables = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        
        userDefaults.removePersistentDomain(forName: "my_user_default")
        userDefaults = nil
        cancellables = nil
    }
    
    func testBoolValueChanges() throws {
        // When
        subject.hasSeen = true
        
        // Then
        XCTAssertTrue(subject.hasSeen)
        XCTAssertEqual(userDefaults.object(forKey: "has_seen") as? Bool, true)
    }
    
    func testStringArrayValueChanges() throws {
        // Given
        let strings = ["ack", "kategories"]
        
        // When
        subject.stringArray = strings
        
        // Then
        XCTAssertEqual(subject.stringArray, strings)
        XCTAssertEqual(userDefaults.object(forKey: "string_array") as? [String], strings)
    }
    
    func testSettingCodableValue() throws {
        // Given
        let value = CodableValue(
            stringValue: .random(),
            intValue: .random()
        )
        
        // When
        subject.codableValue = value
        
        // Then
        XCTAssertEqual(subject.codableValue, value)
        let data = try XCTUnwrap(userDefaults.object(forKey: "codable_value") as? Data)
        XCTAssertEqual(try decoder.decode([CodableValue].self, from: data), [value])
    }

    func test_projectedValue() {
        var values = [Bool]()

        subject.$hasSeen.sink { value in
            values.append(value)
        }.store(in: &cancellables)

        subject.hasSeen = true
        XCTAssertEqual([false, true], values)
    }

    func testFailedWriteIsNotPublished() {
        // Given
        let persisted = FloatingValue(ratio: 0.5)
        subject.ratio = persisted

        var published = [FloatingValue?]()
        subject.$ratio.sink { published.append($0) }.store(in: &cancellables)

        // When – `JSONEncoder` rejects non-conforming floats, so this write cannot reach `UserDefaults`
        subject.ratio = FloatingValue(ratio: .infinity)

        // Then – nothing was published, and the getter still agrees with the publisher
        XCTAssertEqual(published, [persisted])
        XCTAssertEqual(subject.ratio, persisted)

        // And a write that does succeed is still published
        let next = FloatingValue(ratio: 0.75)
        subject.ratio = next
        XCTAssertEqual(published, [persisted, next])
    }
}

private struct MyUserDefaultProvider {
    @UserDefault("has_seen", default: false, userDefaults: UserDefaults(suiteName: "my_user_default")!)
    var hasSeen: Bool
    
    @UserDefault("string_array", default: [], userDefaults: UserDefaults(suiteName: "my_user_default")!)
    var stringArray: [String]
    
    @UserDefault("codable_value", userDefaults: UserDefaults(suiteName: "my_user_default")!)
    var codableValue: CodableValue?

    @UserDefault("ratio", userDefaults: UserDefaults(suiteName: "my_user_default")!)
    var ratio: FloatingValue?
}

private struct CodableValue: Codable, Equatable {
    let stringValue: String
    let intValue: Int
}

private struct FloatingValue: Codable, Equatable {
    let ratio: Double
}
