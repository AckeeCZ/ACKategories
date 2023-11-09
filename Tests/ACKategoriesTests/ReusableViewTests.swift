import ACKategories
import UIKit
import XCTest

final class ReusableViewTests: XCTestCase {
    func test_tableViewCellPrototype_isCached() {
        final class CustomCell: UITableViewCell { }
        
        let tableView = UITableView()
        let prototype = tableView.prototypeCell(type: CustomCell.self)
        let prototype2 = tableView.prototypeCell(type: CustomCell.self)
        
        XCTAssertTrue(prototype === prototype2)
        XCTAssertFalse(prototype === CustomCell())
    }
    
    func test_collectionViewCellPrototype_isCached() {
        final class CustomCell: UICollectionViewCell { }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let prototype = collectionView.prototypeCell(type: CustomCell.self)
        let prototype2 = collectionView.prototypeCell(type: CustomCell.self)
        
        XCTAssertTrue(prototype === prototype2)
        XCTAssertFalse(prototype === CustomCell())
    }
    
    func test_collectionViewSupplementaryViewPrototype_isCached() {
        final class CustomView: UICollectionReusableView { }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let prototype = collectionView.prototypeSupplementaryView(ofKind: "view", type: CustomView.self)
        let prototype2 = collectionView.prototypeSupplementaryView(ofKind: "view", type: CustomView.self)
        
        XCTAssertTrue(prototype === prototype2)
        XCTAssertFalse(prototype === CustomView())
    }
}
