import UIKit

// swiftlint:disable force_cast

extension UITableViewCell: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }
extension UICollectionReusableView: Reusable { }

private enum Keys {
    static var prototypeCellStorage = UInt8(0)
}

extension UITableView {
    /// Storage for prototype cells
    private var prototypeCells: [String: UITableViewCell] {
        get {
            objc_getAssociatedObject(self, &Keys.prototypeCellStorage) as? [String: UITableViewCell] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &Keys.prototypeCellStorage, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// Dequeues `UITableViewCell` generically according to expression result type
    ///
    /// Cell doesn't need to be registered as this method registers it before use.
    public func dequeueCell<T>(for indexPath: IndexPath, type: T.Type = T.self) -> T where T: UITableViewCell {
        register(T.classForCoder(), forCellReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    /// Get prototype cell of given type
    public func prototypeCell<T>(type: T.Type = T.self) -> T where T: UITableViewCell {
        if let prototype = prototypeCells[T.reuseIdentifier] as? T {
            return prototype
        }

        let prototype = T()
        prototypeCells[T.reuseIdentifier] = prototype
        return prototype
    }

    /// Dequeues `UITableViewHeaderFooterView` generically according to expression result type
    ///
    /// View doesn't need to be registered as this method registers it before use.
    public func dequeueHeaderFooterView<T>(type: T.Type = T.self) -> T where T: UITableViewHeaderFooterView {
        register(T.classForCoder(), forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension UICollectionView {
    /// Storage for prototype cells
    private var prototypeCells: [String: UICollectionViewCell] {
        get {
            objc_getAssociatedObject(self, &Keys.prototypeCellStorage) as? [String: UICollectionViewCell] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &Keys.prototypeCellStorage, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    /// Dequeues `UICollectionViewCell` generically according to expression result type
    ///
    /// Cell doesn't need to be registered as this method registers it before use.
    public func dequeueCell<T>(for indexPath: IndexPath, type: T.Type = T.self) -> T where T: UICollectionViewCell {
        register(T.classForCoder(), forCellWithReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    /// Get prototype cell of given type
    public func prototypeCell<T>(type: T.Type = T.self) -> T where T: UICollectionViewCell {
        if let prototype = prototypeCells[T.reuseIdentifier] as? T {
            return prototype
        }

        let prototype = T()
        prototypeCells[T.reuseIdentifier] = prototype
        return prototype
    }

    /// Dequeues `UICollectionReusableView` generically according to expression result type
    ///
    /// View doesn't need to be registered as this method registers it before use.
    public func dequeueSupplementaryView<T>(ofKind kind: String, for indexPath: IndexPath, type: T.Type = T.self) -> T where T: UICollectionReusableView {
        register(T.classForCoder(), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
