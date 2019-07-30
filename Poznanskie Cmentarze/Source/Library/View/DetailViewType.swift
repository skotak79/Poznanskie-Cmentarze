//
//  DetailViewType.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 22.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation
import MapKit

protocol DetailViewType {
    var annotation: MKPointAnnotation { get }
    var tileRenderer: MKOverlayRenderer { get }
}

extension DetailViewType where Self: UIView {
    internal func makeLabel() -> UILabel {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.preferredCustomFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = Color.background
        return label
    }

    internal func setTileRenderer(on mapView: MKMapView) -> MKTileOverlayRenderer {
        let template = "https://tile.openstreetmap.org/{z}/{x}/{y}.png"
        let overlay = MKTileOverlay(urlTemplate: template)
        overlay.canReplaceMapContent = true
        overlay.maximumZ = 19
        mapView.addOverlay(overlay, level: .aboveLabels)
        return MKTileOverlayRenderer(tileOverlay: overlay)
    }
    
    internal func addAnnotation(annotation: MKPointAnnotation, from location: CLLocationCoordinate2D, on mapView: MKMapView) {
        annotation.coordinate = CLLocationCoordinate2D(latitude: (location.latitude), longitude: (location.longitude))
        mapView.addAnnotation(annotation)
    }
}
