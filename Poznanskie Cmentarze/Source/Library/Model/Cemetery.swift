//
//  Cemetery.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 11.05.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

struct Cemetery: Codable {
    /// id of the cemetery
    let id: Int
    let geometry: Geometry
    let properties: Properties

struct Geometry: Codable {
    /// a rectangle bounding outline of the cemetery, of type POLYGON, coordinate system WGS 84 (EPSG:4326)
    let coordinates: [[[Double]]]
    let type: String
}

struct Properties: Codable {
    /// Name of the cemetery
    let name: String
    /// Type of the cemetery
    let type: String
    /// search criteria: 1 – use, 0 – not use
    let cmQDateDeath: Int
    let cmQQuarter: Int
    let cmQDateBirth: Int
    let cmQDateBurial: Int
    let cmQField: Int
    let cmQFamily: Int
    let cmQName: Double
    let cmQSurname: Double
    let cmQRow: Int
    let cmQSurnameName: Int
    }
}

extension Cemetery {
    enum CodingKeys: String, CodingKey {
        case id
        case geometry
        case properties
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        geometry = try values.decode(Geometry.self, forKey: .geometry)
        properties = try values.decode(Properties.self, forKey: .properties)
    }

    var coordinates: [CLLocationCoordinate2D] {
        return geometry.coordinates
            .flatMap {$0}
            .map {CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])}
    }

    // not used
    var bottomLeftCoordinate: CLLocationCoordinate2D {
        return coordinates[0]
    }

    var topLeftCoordinate: CLLocationCoordinate2D {
        return coordinates[1]
    }

    // not used
    var topRightCoordinate: CLLocationCoordinate2D {
        return coordinates[2]
    }

    var bottomRightCoordinate: CLLocationCoordinate2D {
        return coordinates[3]
    }
}

extension Cemetery.Geometry {
    enum CodingKeys: String, CodingKey {
        case coordinates
        case type
    }
}

extension Cemetery.Properties {
    enum CodingKeys: String, CodingKey {
        case cmQDateDeath = "cm_q_date_death"
        case cmQQuarter = "cm_q_quarter"
        case cmQDateBirth = "cm_q_date_birth"
        case name = "cm_name"
        case cmQDateBurial = "cm_q_date_burial"
        case cmQField = "cm_q_field"
        case cmQFamily = "cm_q_family"
        case cmQName = "cm_q_name"
        case cmQSurname = "cm_q_surname"
        case cmQRow = "cm_q_row"
        case cmQSurnameName = "cm_q_surname_name"
        case type = "cm_type"
    }
}

extension Cemetery {
    var attributedTitle: NSAttributedString {
        let font = UIFont.preferredCustomFont(forTextStyle: .headline)
        let titleString = self.properties.name.attributtedString(with: font, foregroundColor: .darkText)

        return titleString
    }
    var attributedSubtitle: NSAttributedString {
        let font = UIFont.preferredCustomFont(forTextStyle: .caption1)
        let subtitleString = self.properties.type.attributtedString(with: font, foregroundColor: .darkGray)

        return subtitleString
    }
}
