#if canImport(UIKit) && !os(watchOS)
import UIKit
import XCTest
import ACKategories

final class UIViewTests: XCTestCase {
    func testForceIntrinsic() {
        let view = UIView()
        let dummyPriority = UILayoutPriority(rawValue: 10)
        view.setContentCompressionResistancePriority(dummyPriority, for: .vertical)
        view.setContentCompressionResistancePriority(dummyPriority, for: .horizontal)
        view.setContentHuggingPriority(dummyPriority, for: .vertical)
        view.setContentHuggingPriority(dummyPriority, for: .horizontal)
        
        view.forceIntrinsic()
        
        XCTAssertEqual(view.contentHuggingPriority(for: .vertical), .required)
        XCTAssertEqual(view.contentHuggingPriority(for: .horizontal), .required)
        XCTAssertEqual(view.contentCompressionResistancePriority(for: .horizontal), .required)
        XCTAssertEqual(view.contentCompressionResistancePriority(for: .vertical), .required)
    }
    
    func test_spacer_initialIsHidden() {
        let view = UIView()
        view.isHidden = false
        let spacer = view.createVSpacer(10)
        
        XCTAssertEqual(view.isHidden, spacer.isHidden)
        
        let view2 = UIView()
        view2.isHidden = true
        let spacer2 = view2.createVSpacer(10)
        
        XCTAssertEqual(view2.isHidden, spacer2.isHidden)
    }
    
    func test_spacer_isHiddenObservation() {
        let view = UIView()
        view.isHidden = false
        let spacer = view.createVSpacer(10)
        
        XCTAssertEqual(view.isHidden, spacer.isHidden)
        
        view.isHidden = true
        XCTAssertEqual(view.isHidden, spacer.isHidden)
    }
    
    func test_spacer_isDeinited() throws {
        let parent = UIView()
        
        weak var weakView: UIView?
        weak var weakSpacer: UIView?
        
        try autoreleasepool {
            var view: UIView? = UIView()
            var spacer: UIView? = try XCTUnwrap(view).createVSpacer(10)
            
            try parent.addSubview(XCTUnwrap(view))
            try parent.addSubview(XCTUnwrap(spacer))
            
            weakView = view
            weakSpacer = spacer
            
            view = nil
            spacer = nil
            
            XCTAssertNotNil(weakView)
            XCTAssertNotNil(weakSpacer)
            
            weakView?.removeFromSuperview()
            weakSpacer?.removeFromSuperview()
        }
        
        XCTAssertNil(weakView)
        XCTAssertNil(weakSpacer)
    }
}
#endif
