import Foundation
import XCTest
@testable import ACKategoriesCore

final class UserDefaultTests: XCTestCase {
    private var subject: MyUserDefaultProvider!
    private var userDefaults: UserDefaults!
    private var decoder: JSONDecoder!
    
    override func setUp() {
        super.setUp()
        
        decoder = JSONDecoder()
        userDefaults = UserDefaults(suiteName: "my_user_default")
        subject = MyUserDefaultProvider()
    }
    
    override func tearDown() {
        super.tearDown()
        
        userDefaults.removePersistentDomain(forName: "my_user_default")
        userDefaults = nil
    }
    
    func testBoolValueChanges() throws {
        // When
        subject.hasSeen = true
        
        // Then
        XCTAssertTrue(subject.hasSeen)
        let hasSeenData = try XCTUnwrap(userDefaults.object(forKey: "has_seen") as? Data)
        XCTAssertEqual(try decoder.decode(Bool.self, from: hasSeenData), true)
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
        XCTAssertEqual(try decoder.decode(CodableValue.self, from: data), value)
    }
}

private struct MyUserDefaultProvider {
    @UserDefault("has_seen", default: false, userDefaults: UserDefaults(suiteName: "my_user_default")!)
    var hasSeen: Bool
    
    @UserDefault("codable_value", userDefaults: UserDefaults(suiteName: "my_user_default")!)
    var codableValue: CodableValue?
}

private struct CodableValue: Codable, Equatable {
    let stringValue: String
    let intValue: Int
}
