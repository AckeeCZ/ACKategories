//
//  MapViewController.swift
//  ACKategories-Example
//
//  Created by Vendula Švastalová on 29/11/2019.
//  Copyright © 2019 Ackee, s.r.o. All rights reserved.
//

import UIKit
import ACKategories
import MapKit

final class MapViewController: BaseViewController<MapViewModeling> {
    private weak var mapView: MKMapView!

    override func loadView() {
        super.loadView()
        let mapView = MKMapView()
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.mapView = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let annotations = viewModel.annotations
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: false)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if #available(iOS 11.0, *) {
            let annotationView: MKMarkerAnnotationView = mapView.dequeueAnnotationView(for: annotation)
            return annotationView
        } else {
            let annotationView: MKAnnotationView = mapView.dequeueAnnotationView(for: annotation)
            annotationView.image = UIColor.red.image(of: CGSize(width: 30, height: 30))
            return annotationView
        }
    }
}
