import UIKit

extension UITableViewCell {
    public class var cellIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionReusableView {
    public class var viewIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UICollectionViewCell {
    public class var cellIdentifier: String {
        return viewIdentifier
    }
}

extension UITableView {
    public func dequeCellForIndexPath<T>(_ indexPath: IndexPath) -> T where T : UITableViewCell {
        register(T.classForCoder(), forCellReuseIdentifier: T.cellIdentifier)
        return dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    public func dequeCellForIndexPath<T>(_ indexPath: IndexPath) -> T where T : UICollectionViewCell {
        register(T.classForCoder(), forCellWithReuseIdentifier: T.cellIdentifier)
        return dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
}

