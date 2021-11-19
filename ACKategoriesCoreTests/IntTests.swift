import ACKategoriesCore
import XCTest

final class IntTests: XCTestCase {
    func test_safeInit_doubleNAN() {
        XCTAssertNil(Int(safe: Double.nan))
    }
    
    func test_safeInit_floatNAN() {
        XCTAssertNil(Int(safe: Float.nan))
    }
    
    func test_safeInit_cgFloatNAN() {
        XCTAssertNil(Int(safe: CGFloat.nan))
    }
    
    func test_safeInit_doubleInfinity() {
        XCTAssertNil(Int(safe: Double.infinity))
    }
    
    func test_safeInit_floatInfinity() {
        XCTAssertNil(Int(safe: Float.infinity))
    }
    
    func test_safeInit_cgFloatInfinity() {
        XCTAssertNil(Int(safe: CGFloat.infinity))
    }
    
    func test_safeInit_doubleValid() {
        let value = Double.random(in: -1000...1000)
        
        XCTAssertEqual(Int(value), Int(safe: value))
    }
    
    func test_safeInit_floatValid() {
        let value = Float.random(in: -1000...1000)
        
        XCTAssertEqual(Int(value), Int(safe: value))
    }
    
    func test_safeInit_cgFloatValid() {
        let value = CGFloat.random(in: -1000...1000)
        
        XCTAssertEqual(Int(value), Int(safe: value))
    }
}
