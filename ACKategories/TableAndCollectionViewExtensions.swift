import UIKit

public protocol Reusable { }

extension Reusable {
    /// Reuse identifier
    public static var reuseIdentifier: String {
        return NSStringFromClass(self as! AnyObject.Type)
    }
}

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
extension UICollectionReusableView: Reusable { }

extension UITableView {
    /// Dequeues `UITableViewCell` generically according to expression result type
    ///
    /// Cell doesn't need to be registered as this method registers it before use.
    public func dequeueCell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        register(T.classForCoder(), forCellReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    /// Dequeues `UITableViewHeaderFooterView` generically according to expression result type
    ///
    /// View doesn't need to be registered as this method registers it before use.
    public func dequeueHeaderFooterView<T>() -> T where T: UITableViewHeaderFooterView {
        register(T.classForCoder(), forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension UICollectionView {
    /// Dequeues `UICollectionViewCell` generically according to expression result type
    ///
    /// Cell doesn't need to be registered as this method registers it before use.
    public func dequeueCell<T>(for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        register(T.classForCoder(), forCellWithReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    /// Dequeues `UICollectionReusableView` generically according to expression result type
    ///
    /// View doesn't need to be registered as this method registers it before use.
    public func dequeueSupplementaryView<T>(ofKind kind: String, for indexPath: IndexPath) -> T where T: UICollectionReusableView {
        register(T.classForCoder(), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
