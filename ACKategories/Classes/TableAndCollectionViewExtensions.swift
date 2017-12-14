import UIKit

public protocol Reusable { }

extension Reusable {
    public static var reuseIdentifier: String {
        return NSStringFromClass(self as! AnyObject.Type)
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
extension UICollectionReusableView: Reusable { }

extension UITableView {
    public func dequeueCell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        register(T.classForCoder(), forCellReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    public func dequeueHeaderFooterView<T>() -> T where T: UITableViewHeaderFooterView {
        register(T.classForCoder(), forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension UICollectionView {
    public func dequeueCell<T>(for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        register(T.classForCoder(), forCellWithReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    public func dequeueSupplementaryView<T>(ofKind kind: String, for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        register(T.classForCoder(), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
