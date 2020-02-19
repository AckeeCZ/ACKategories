//
//  MapViewModel.swift
//  ACKategories-Example
//
//  Created by Vendula Švastalová on 29/11/2019.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import ACKategories
import CoreLocation
import MapKit

protocol MapViewModelingActions {

}

protocol MapViewModeling {
    var annotations: [MKAnnotation] { get }
}

extension MapViewModeling where Self: MapViewModelingActions {
    var actions: MapViewModelingActions { return self }
}

final class MapViewModel: Base.ViewModel, MapViewModeling, MapViewModelingActions {
    private let coordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 49.997441, longitude: 14.187523),
        CLLocationCoordinate2D(latitude: 50.109445, longitude: 14.357311),
        CLLocationCoordinate2D(latitude: 50.075125, longitude: 14.568965)
    ]

    lazy var annotations: [MKAnnotation] = coordinates.map {
        let annotation = MKPointAnnotation()
        annotation.coordinate = $0
        annotation.title = "lat: \(annotation.coordinate.latitude), lon: \(annotation.coordinate.longitude)"
        return annotation
    }
}
