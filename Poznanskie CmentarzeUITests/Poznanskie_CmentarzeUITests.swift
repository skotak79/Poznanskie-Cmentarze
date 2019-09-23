//
//  Poznanskie_CmentarzeUITests.swift
//  Poznanskie CmentarzeUITests
//
//  Created by Wojtek Skotak on 13/04/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import XCTest

class PoznanskieCmentarzeUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    func testScrollingCemeteries() {
        app.launch()
        let tableView = app.tables.element(boundBy: 0)
        tableView.swipeUp()
        tableView.swipeDown()
    }
    func testGoToCemeteryDetail() {
        app.launch()
        let tableView = app.tables.element(boundBy: 0)
        let firstCell = tableView.cells.element(boundBy: 0)
        firstCell.tap()
    }
    func testOpenExternalMapsNavigationToCemetery() {
        testGoToCemeteryDetail()
        let button = app.navigationBars.buttons["Nawiguj"]
        button.tap()
    }
    func testGraveSearch() {
        app.launch()
        let tabBar = app.tabBars.element(boundBy: 0)
        tabBar.buttons["Wyszukiwarka"].tap()
        let searchField = app.searchFields.element(boundBy: 0)
        searchField.tap()
        searchField.typeText("Jan nowak")
        let tableView = app.tables.element(boundBy: 0)
        _ = tableView.waitForExistence(timeout: 8)
        let firstCell = tableView.cells.element(boundBy: 0)
        firstCell.tap()
    }
}
