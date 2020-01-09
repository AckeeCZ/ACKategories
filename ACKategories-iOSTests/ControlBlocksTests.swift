import UIKit
import XCTest
import ACKategories

final class ControlBlocksTests: XCTestCase {

    func testHandlerRunsOnTap() {
        var firstCalled = false
        let button = UIButton()
        
        button.on(.touchUpInside) { _ in
            firstCalled = true
        }
        
        button.sendActions(for: .touchUpInside)
        XCTAssertTrue(firstCalled)
    }

    func testHandlerRunsOnAllRegisteredEvents() {
        var firstCalled = false
        var secondCalled = false
        
        let button = UIButton()
        button.on(.touchUpInside) { sender in
            firstCalled = true
        }
        button.on(.touchDown) { sender in
            secondCalled = true
        }
        
        button.sendActions(for: .touchUpInside)
        XCTAssertTrue(firstCalled)
        
        button.sendActions(for: .touchDown)
        XCTAssertTrue(secondCalled)
    }
    
    func testHoldsOnlyOneHandlerForParticularEvent() {
        var firstCalled = false
        var secondCalled = false
        
        let button = UIButton()
        button.on(.touchUpInside) { sender in
            firstCalled = true
        }
        button.on(.touchUpInside) { sender in
            secondCalled = true
        }
        
        button.sendActions(for: .touchUpInside)
        
        XCTAssertFalse(firstCalled)
        XCTAssertTrue(secondCalled)
    }
    
    func testRunsOneHandlerForMoreEvents() {
        var x = 0
        
        let button = UIButton()
        button.on([.touchUpInside, .touchDown]) { sender in
            x += 1
        }
        button.on(.touchUpInside) { sender in
            x += 1
        }
        
        button.sendActions(for: .touchUpInside)
        button.sendActions(for: .touchDown)
        XCTAssertEqual(3, x)
        
        button.sendActions(for: .touchUpInside)
        XCTAssertEqual(5, x)
    }
    
    func testCanUnregisterActionBlock() {
        var firstCalled = false
        
        let button = UIButton()
        button.on(.touchUpInside) { sender in
            firstCalled = true
        }
        
        button.sendActions(for: .touchUpInside)
        XCTAssertTrue(firstCalled)
        
        firstCalled = false
        button.off(.touchUpInside)
        
        button.sendActions(for: .touchUpInside)
        XCTAssertFalse(firstCalled)
    }
}
