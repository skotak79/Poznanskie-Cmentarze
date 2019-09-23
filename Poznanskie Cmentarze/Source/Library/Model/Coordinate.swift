//
//  Coordinate.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 18/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import MapKit

public struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double

    func locationCoordinate() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
