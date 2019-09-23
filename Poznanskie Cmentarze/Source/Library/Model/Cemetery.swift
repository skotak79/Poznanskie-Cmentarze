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

public struct Cemetery: Codable {
    /// id of the cemetery
    let id: Int
    let geometry: Geometry
    let properties: Properties

struct Geometry: Codable {
    /// a rectangle bounding outline of the cemetery, of type POLYGON, coordinate system WGS 84 (EPSG:4326)
    let coordinates: [Coordinate]
    let type: String
}

struct Properties: Codable {
    /// Name of the cemetery
    let name: String
    /// Type of the cemetery
    let type: String
    }
}

extension Cemetery {
    enum CodingKeys: String, CodingKey {
        case id
        case geometry
        case properties
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        geometry = try values.decode(Geometry.self, forKey: .geometry)
        properties = try values.decode(Properties.self, forKey: .properties)
    }

    // bottomLeftCoordinate = [0], topRightCoordinate = [2]
    var topLeftCoordinate: CLLocationCoordinate2D {
        return self.geometry.coordinates[1].locationCoordinate()
    }

    var bottomRightCoordinate: CLLocationCoordinate2D {
        return self.geometry.coordinates[3].locationCoordinate()
    }
}

extension Cemetery.Geometry {

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(String.self, forKey: .type)
        let coordinatesDouble = try values.decode([[[Double]]].self, forKey: .coordinates)
        coordinates = coordinatesDouble.flatMap {$0}
            .map {Coordinate(latitude: $0[1], longitude: $0[0])}
    }

    enum CodingKeys: String, CodingKey {
        case coordinates
        case type
    }
}

extension Cemetery.Properties {
    enum CodingKeys: String, CodingKey {
        case name = "cm_name"
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
