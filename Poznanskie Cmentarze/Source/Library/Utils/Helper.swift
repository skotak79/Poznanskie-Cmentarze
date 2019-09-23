//
//  Helper.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation
import MapKit

final class Helper {

    /// Calculate geo center of the cemetery
    static func getGeoCenterLocation(of cemetery: Cemetery) -> CLLocationCoordinate2D {
        var mapPoints = [MKMapPoint]()
        mapPoints = cemetery.geometry.coordinates
            .map {MKMapPoint($0.locationCoordinate())}
        let polygon = MKPolygon(points: mapPoints, count: mapPoints.count)
        return polygon.coordinate
    }
}
