//
//  GraveTests.swift
//  Poznanskie CmentarzeTests
//
//  Created by Wojtek Skotak on 20.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import XCTest
@testable import Poznanskie_Cmentarze

class GraveTests: XCTestCase {
    func testParsing() throws {
        let json: [String: Any] = [
            "geometry": [
                "type": "Point",
                "coordinates": [
                16.784709048958401,
                52.476694541324697
                ]
            ],
            "type": "Feature",
            "id": 348682335,
            "properties": [
                "g_date_birth": "1996-01-01",
                "g_quarter": "L",
                "g_surname": "czerwińska",
                "print_surname_name": "",
                "print_name": "",
                "g_surname_name": "",
                "g_place": "10",
                "g_date_death": "1996-06-11",
                "paid": -1,
                "cm_id": 23,
                "cm_nr": 73849,
                "g_row": "4",
                "g_family": "                              ",
                "g_name": "",
                "print_surname": "Czerwińska",
                "g_field": "",
                "g_date_burial": "0001-01-01",
                "g_size": ""
            ]
        ]
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        let decoder = JSONDecoder()
        let grave = try decoder.decode(Grave.self, from: data)
        XCTAssertEqual(grave.id, 348682335)
        XCTAssertEqual(grave.properties.cmId, 23)
        XCTAssertEqual(grave.properties.field, "")
        XCTAssertEqual(grave.properties.surname, "czerwińska")
        XCTAssertEqual(grave.geometry.coordinates.longitude, 16.784709048958401)
    }
}
