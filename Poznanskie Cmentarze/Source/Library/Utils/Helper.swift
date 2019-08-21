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
        mapPoints = cemetery.coordinates
            .map {MKMapPoint($0)}
        let polygon = MKPolygon(points: mapPoints, count: mapPoints.count)
        return polygon.coordinate
    }

    static func date(from string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: string)
        return date!
    }
}
