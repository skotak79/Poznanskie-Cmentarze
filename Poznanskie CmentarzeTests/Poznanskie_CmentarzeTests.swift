//
//  Poznanskie_CmentarzeTests.swift
//  Poznanskie CmentarzeTests
//
//  Created by Wojtek Skotak on 13/04/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import XCTest
@testable import Poznanskie_Cmentarze

class PoznanskieCmentarzeTests: XCTestCase {

    func testExample() {
        do {
            try R.validate()
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
