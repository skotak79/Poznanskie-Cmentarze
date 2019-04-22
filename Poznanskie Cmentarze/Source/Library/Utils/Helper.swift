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
    /// used to identify the cemetery of the grave
    static var cemeteryIdsWithNames: [Int: String] = [:]

    /// Calculate geo center of the cemetery
    static func getGeoCenterLocation(of cemetery: Cemetery) -> CLLocationCoordinate2D {
        var mapPoints = [MKMapPoint]()
        mapPoints = cemetery.coordinates
            .flatMap {$0}
            .map {CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])}
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
