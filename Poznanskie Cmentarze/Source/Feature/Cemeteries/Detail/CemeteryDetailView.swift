//
//  CemeteryDetailView.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 10.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit
import MapKit

final class CemeteryDetailView: UIView, DetailViewType {

    private let mapView = MKMapView()
    internal var tileRenderer = MKOverlayRenderer()
    internal let annotation = MKPointAnnotation()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func addMapAnnotation(from location: CLLocationCoordinate2D) {
        addAnnotation(annotation: annotation, from: location, on: mapView)
    }
    
    // MARK: - Setup
    
    private func setupConstraints() {
        addSubview(mapView)
        NSLayoutConstraint.pin(view: mapView, toEdgesOf: self)
        setupMap()
    }

    private func setupMap() {
        tileRenderer = setTileRenderer(on: mapView)
        mapView.delegate = self
    }
}

extension CemeteryDetailView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return tileRenderer
    }
}
