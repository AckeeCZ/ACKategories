import UIKit
import MapKit

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
extension MKAnnotationView: Reusable { }

extension UITableView {
    /// Dequeues `UITableViewCell` generically according to expression result type
    ///
    /// Cell doesn't need to be registered as this method registers it before use.
    public func dequeueCell<T>(for indexPath: IndexPath, type: T.Type = T.self) -> T where T: UITableViewCell {
        register(T.classForCoder(), forCellReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
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
    /// Dequeues `UICollectionViewCell` generically according to expression result type
    ///
    /// Cell doesn't need to be registered as this method registers it before use.
    public func dequeueCell<T>(for indexPath: IndexPath, type: T.Type = T.self) -> T where T: UICollectionViewCell {
        register(T.classForCoder(), forCellWithReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    /// Dequeues `UICollectionReusableView` generically according to expression result type
    ///
    /// View doesn't need to be registered as this method registers it before use.
    public func dequeueSupplementaryView<T>(ofKind kind: String, for indexPath: IndexPath, type: T.Type = T.self) -> T where T: UICollectionReusableView {
        register(T.classForCoder(), forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

extension MKMapView {
    /// Dequeues `MKAnnotationView` generically according to expression result type.
    ///
    /// Annotation view doesn't need to be registered as this method registers it before usage.
    ///
    /// For iOS versions lower than `iOS 11.0` the Annotation view is dequeued at first and then created if non-exitent.
    public func dequeueAnnotationView<T>(for annotation: MKAnnotation) -> T where T: MKAnnotationView {
        if #available(iOS 11.0, *) {
            register(T.classForCoder(), forAnnotationViewWithReuseIdentifier: T.reuseIdentifier)
            return dequeueReusableAnnotationView(withIdentifier: T.reuseIdentifier, for: annotation) as! T
        } else {
            if let annotationView = dequeueReusableAnnotationView(withIdentifier: T.reuseIdentifier) {
                annotationView.annotation = annotation
                return annotationView as! T
            }
            
            let annotationView = T()
            annotationView.annotation = annotation
            return annotationView
        }
    }
}
