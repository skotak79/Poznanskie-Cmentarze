//
//  CemeteryTests.swift
//  Poznanskie CmentarzeTests
//
//  Created by Wojtek Skotak on 20.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import XCTest
@testable import Poznanskie_Cmentarze

class CemeteryTests: XCTestCase {
    func testParsing() throws {
        let json: [String: Any] = [
                    "geometry": [
                        "type": "Polygon",
                        "coordinates": [
                            [
                                [
                                    16.993566513061499,
                                    52.411720275878899
                                ],
                                [
                                    16.993566513061499,
                                    52.425388336181598
                                ],
                                [
                                    17.012189865112301,
                                    52.425388336181598
                                ],
                                [
                                    17.012189865112301,
                                    52.411720275878899
                                ],
                                [
                                    16.993566513061499,
                                    52.411720275878899
                                ]
                            ]
                        ]
                    ],
                    "type": "Feature",
                    "id": 1,
                    "properties": [
                        "cm_name": "Miłostowo",
                        "cm_q_quarter": 1,
                        "cm_q_surname_name": 0,
                        "cm_q_family": 1,
                        "cm_q_date_birth": 1,
                        "cm_q_date_death": 0,
                        "cm_q_field": 1,
                        "cm_q_row": 1,
                        "cm_q_name": 1,
                        "cm_type": "komunalny           ",
                        "cm_q_date_burial": 1,
                        "cm_q_surname": 1
                    ]
                ]
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        let decoder = JSONDecoder()
        let cemetery = try decoder.decode(Cemetery.self, from: data)
        XCTAssertEqual(cemetery.id, 1)
        XCTAssertEqual(cemetery.name, "Miłostowo")
        XCTAssertEqual(cemetery.coordinates[0][0][0], 16.993566513061499)
    }
}
