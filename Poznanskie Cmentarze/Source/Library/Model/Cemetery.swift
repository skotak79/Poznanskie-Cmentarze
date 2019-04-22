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
    fileprivate let geometry: Geometry
    fileprivate let properties: Properties
}

private struct Geometry: Codable {
    /// a rectangle bounding outline of the cemetery, of type POLYGON, coordinate system WGS 84 (EPSG:4326)
    let coordinates: [[[Double]]]
    let type: String
}

private struct Properties: Codable {
    /// Name of the cemetery
    let cmName: String
    /// Type of the cemetery
    let cmType: String
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

    var name: String {
        return properties.cmName
    }
    var type: String {
        return properties.cmType.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var coordinates: [[[Double]]] {
        return geometry.coordinates
    }
}

extension Geometry {
    enum CodingKeys: String, CodingKey {
        case coordinates
        case type
    }
}

extension Properties {
    enum CodingKeys: String, CodingKey {
        case cmQDateDeath = "cm_q_date_death"
        case cmQQuarter = "cm_q_quarter"
        case cmQDateBirth = "cm_q_date_birth"
        case cmName = "cm_name"
        case cmQDateBurial = "cm_q_date_burial"
        case cmQField = "cm_q_field"
        case cmQFamily = "cm_q_family"
        case cmQName = "cm_q_name"
        case cmQSurname = "cm_q_surname"
        case cmQRow = "cm_q_row"
        case cmQSurnameName = "cm_q_surname_name"
        case cmType = "cm_type"
    }
}

extension Cemetery {
    var attributedTitle: NSAttributedString {
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredCustomFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.darkText]
        let titleString = NSMutableAttributedString(string: self.name, attributes: titleAttributes)

        return titleString
    }
    var attributedSubtitle: NSAttributedString {
        let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredCustomFont(forTextStyle: .caption1), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        let subtitleString = NSMutableAttributedString(string: self.type, attributes: subtitleAttributes)
        return subtitleString
    }
}
