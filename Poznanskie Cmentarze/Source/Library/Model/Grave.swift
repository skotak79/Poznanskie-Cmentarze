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
    let geometry: Geometry
    let properties: Properties
    let type: String

struct Geometry: Codable {
    /// point, coordinate system WGS 84
    let coordinates: [Double]
    let type: String
}

struct Properties: Codable {
    // person's name
    let name: String
    // date of the burial
    let dateBurial: String
    /// not used
    let cmNr: Int
    /// id of the cemetery
    let cmId: Int
    /// date of birth
    let dateBirth: String
    /// type of the grave
    let gFamily: String
    /// date of death
    let dateDeath: String
    /// field of the grave
    let field: String
    /// number of people buried in the grave
    let gSize: String
    /// quarter of the grave
    let quarter: String
    /// place of the grave
    let place: String
    /// row of the grave
    let row: String
    /// person's name(s) and surname - use instead of g_surname i g_name for  Lubowska and Samotna cemeteries. Military rank for the Cemetery of Soviet Soldiers
    let surnameName: String
    let printName: String
    /// person's surname
    let surname: String
    /// is grave paid?
    let paid: Int
    let printSurname: String
    let printSurnameName: String
    }
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

    var location: CLLocationCoordinate2D? {
        let coordinates = self.geometry.coordinates

        return coordinates.isEmpty ? nil : CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
    }

    var nameAndSurname: (String, String) {
        guard self.properties.cmId == IdsForUniqueCemeteries.lubowska || self.properties.cmId == IdsForUniqueCemeteries.samotna else {
            return (self.properties.name.isEmpty ? "?" : self.properties.name, self.properties.surname)
        }
        let localSurnameName = Name(surnameName: self.properties.surnameName)
        let firstName = localSurnameName.firstName
        let surname = localSurnameName.surname
        return (firstName, surname)
    }
}

extension Grave.Geometry {
    enum CodingKeys: String, CodingKey {
        case coordinates
        case type
    }
}

extension Grave.Properties {
    enum CodingKeys: String, CodingKey {
        case name = "g_name"
        case dateBurial = "g_date_burial"
        case cmNr = "cm_nr"
        case cmId = "cm_id"
        case dateBirth = "g_date_birth"
        case gFamily = "g_family"
        case dateDeath = "g_date_death"
        case field = "g_field"
        case gSize = "g_size"
        case quarter = "g_quarter"
        case place = "g_place"
        case row = "g_row"
        case surnameName = "g_surname_name"
        case printName = "print_name"
        case surname = "g_surname"
        case paid
        case printSurname = "print_surname"
        case printSurnameName = "print_surname_name"
    }
}
