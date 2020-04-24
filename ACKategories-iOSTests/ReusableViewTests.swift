import ACKategories
import UIKit
import XCTest

final class ReusableViewTests: XCTestCase {
    func testTableViewCellPrototypeIsCached() {
        final class CustomCell: UITableViewCell { }
        
        let tableView = UITableView()
        let prototype = tableView.prototypeCell(type: CustomCell.self)
        let prototype2 = tableView.prototypeCell(type: CustomCell.self)
        
        XCTAssertTrue(prototype === prototype2)
        XCTAssertFalse(prototype === CustomCell())
    }
    
    func testCollectionViewCellPrototypeIsCached() {
        final class CustomCell: UICollectionViewCell { }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let prototype = collectionView.prototypeCell(type: CustomCell.self)
        let prototype2 = collectionView.prototypeCell(type: CustomCell.self)
        
        XCTAssertTrue(prototype === prototype2)
        XCTAssertFalse(prototype === CustomCell())
    }
}
