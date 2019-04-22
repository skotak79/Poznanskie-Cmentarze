//
//  Grave.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 12.05.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation
import CoreLocation

struct Grave: Codable {
    /// id of the grave
    let id: Int
    fileprivate let geometry: Geometry
    fileprivate let properties: Properties
    fileprivate let type: String
}

private struct Geometry: Codable {
    /// point, coordinate system WGS 84
    let coordinates: [Double]
    let type: String
}

private struct Properties: Codable {
    // person's name
    let gName: String
    // date of the burial
    let gDateBurial: String
    /// not used
    let cmNr: Int
    /// id of the cemetery
    let cmId: Int
    /// date of birth
    let gDateBirth: String
    /// type of the grave
    let gFamily: String
    /// date of death
    let gDateDeath: String
    /// field of the grave
    let gField: String
    /// number of people buried in the grave
    let gSize: String
    /// quarter of the grave
    let gQuarter: String
    /// place of the grave
    let gPlace: String
    /// row of the grave
    let gRow: String
    /// person's name(s) and surname - use instead of g_surname i g_name for  Lubowska and Samotna cemeteries. Military rank for the Cemetery of Soviet Soldiers
    let gSurnameName: String
    let printName: String
    /// person's surname
    let gSurname: String
    /// is grave paid?
    let paid: Int
    let printSurname: String
    let printSurnameName: String
}

extension Grave {
    enum CodingKeys: String, CodingKey {
        case id
        case geometry
        case properties
        case type
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        geometry = try values.decode(Geometry.self, forKey: .geometry)
        properties = try values.decode(Properties.self, forKey: .properties)
        type = try values.decode(String.self, forKey: .type)
    }
    var coordinates: [Double] {
        return geometry.coordinates
    }
    var name: String {
        return properties.gName
    }
    var surname: String {
        return properties.gSurname
    }
    var surnameName: String {
        return properties.gSurnameName
    }
    var dateBirth: String {
        return properties.gDateBirth
    }
    var dateDeath: String {
        return properties.gDateDeath
    }
    var dateBurial: String {
        return properties.gDateBurial
    }
    var cmId: Int {
        return properties.cmId
    }
    var row: String {
        return properties.gRow
    }
    var quarter: String {
        return properties.gQuarter
    }
    var field: String {
        return properties.gField
    }
    var place: String {
        return properties.gPlace
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
        case gName = "g_name"
        case gDateBurial = "g_date_burial"
        case cmNr = "cm_nr"
        case cmId = "cm_id"
        case gDateBirth = "g_date_birth"
        case gFamily = "g_family"
        case gDateDeath = "g_date_death"
        case gField = "g_field"
        case gSize = "g_size"
        case gQuarter = "g_quarter"
        case gPlace = "g_place"
        case gRow = "g_row"
        case gSurnameName = "g_surname_name"
        case printName = "print_name"
        case gSurname = "g_surname"
        case paid
        case printSurname = "print_surname"
        case printSurnameName = "print_surname_name"
    }
}
