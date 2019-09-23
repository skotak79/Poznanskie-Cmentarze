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
    let coordinates: Coordinate
    let type: String
}

struct Properties: Codable {
    // person's name
    let name: String
    // date of the burial
    let dateBurial: Date
    /// id of the cemetery
    let cmId: Int
    /// date of birth
    let dateBirth: Date
    /// date of death
    let dateDeath: Date
    /// field of the grave
    let field: String
    /// quarter of the grave
    let quarter: String
    /// place of the grave
    let place: String
    /// row of the grave
    let row: String
    /// person's name(s) and surname - use instead of g_surname i g_name for Lubowska and Samotna cemeteries. Military rank for the Cemetery of Soviet Soldiers
    let surnameName: String
    let printName: String
    /// person's surname
    let surname: String
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
}

extension Grave.Geometry {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(String.self, forKey: .type)
        let coordinatesDouble = try values.decode([Double].self, forKey: .coordinates)
        coordinates = Coordinate(latitude: coordinatesDouble[1], longitude: coordinatesDouble[0])
    }

    enum CodingKeys: String, CodingKey {
        case coordinates
        case type
    }
}

extension Grave.Properties {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        surname = try container.decode(String.self, forKey: .surname)
        cmId = try container.decode(Int.self, forKey: .cmId)
        field = try container.decode(String.self, forKey: .field)
        quarter = try container.decode(String.self, forKey: .quarter)
        place = try container.decode(String.self, forKey: .place)
        row = try container.decode(String.self, forKey: .row)
        surnameName = try container.decode(String.self, forKey: .surnameName)
        printName = try container.decode(String.self, forKey: .printName)
        printSurnameName = try container.decode(String.self, forKey: .printSurnameName)
        printSurname = try container.decode(String.self, forKey: .printSurname)
        dateBirth = try container.decode(DefaultDateWrapper.self, forKey: .dateBirth).value
        dateDeath = try container.decode(DefaultDateWrapper.self, forKey: .dateDeath).value
        dateBurial = try container.decode(DefaultDateWrapper.self, forKey: .dateBurial).value
    }

    enum CodingKeys: String, CodingKey {
        case name = "g_name"
        case dateBurial = "g_date_burial"
        case cmId = "cm_id"
        case dateBirth = "g_date_birth"
        case dateDeath = "g_date_death"
        case field = "g_field"
        case quarter = "g_quarter"
        case place = "g_place"
        case row = "g_row"
        case surnameName = "g_surname_name"
        case printName = "print_name"
        case surname = "g_surname"
        case printSurname = "print_surname"
        case printSurnameName = "print_surname_name"
    }
}

func valueNotFound<T>(codingPath: [CodingKey], debugDescription: String) throws -> T {
    let context = DecodingError.Context(codingPath: codingPath, debugDescription: debugDescription)
    throw DecodingError.valueNotFound(T.self, context)
}

struct DefaultDateWrapper {
    let value: Date
}

extension DefaultDateWrapper: Swift.Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try DateFormatter.default.date(from: container.decode(String.self))
            ?? valueNotFound(codingPath: [], debugDescription: "can not convert to Date")
    }
}
