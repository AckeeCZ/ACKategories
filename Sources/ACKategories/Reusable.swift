//
//  Reusable.swift
//  ACKategories
//
//  Created by Jakub Olejník on 09/01/2020.
//

import MapKit

// swiftlint:disable force_cast

public protocol Reusable { }

extension Reusable {
    /// Reuse identifier
    public static var reuseIdentifier: String {
        return NSStringFromClass(self as! AnyObject.Type)
    }
}

extension MKAnnotationView: Reusable { }

extension MKMapView {
    /// Dequeues `MKAnnotationView` generically according to expression result type.
    ///
    /// Annotation view doesn't need to be registered as this method registers it before usage.
    ///
    /// For iOS versions lower than `iOS 11.0` the Annotation view is dequeued at first and then created if non-exitent.
    public func dequeueAnnotationView<T>(for annotation: MKAnnotation, type: T.Type = T.self) -> T where T: MKAnnotationView {
        register(T.classForCoder(), forAnnotationViewWithReuseIdentifier: T.reuseIdentifier)
        return dequeueReusableAnnotationView(withIdentifier: T.reuseIdentifier, for: annotation) as! T
    }
}
