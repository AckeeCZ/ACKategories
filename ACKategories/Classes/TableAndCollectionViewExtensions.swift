import UIKit

public protocol Reusable { }

extension Reusable {
    
    public static var reuseIdentifier: String {
        return NSStringFromClass(self as! AnyObject.Type)
    }
    
}

extension UITableViewCell: Reusable { }
extension UICollectionReusableView: Reusable { }

extension UITableView {
    public func dequeueCell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        register(T.classForCoder(), forCellReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    public func dequeueCell<T>(for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        register(T.classForCoder(), forCellWithReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
