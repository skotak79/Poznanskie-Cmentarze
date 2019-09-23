//
//  SearchModelTests.swift
//  Poznanskie CmentarzeTests
//
//  Created by Wojtek Skotak on 21/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import XCTest
@testable import Poznanskie_Cmentarze
class SearchModelTests: XCTestCase {

    var searchModel: SearchModel!

    override func setUp() {
        let mockNetworkEngine = MockNetworkEngine(fileName: "graves")
        searchModel = SearchModel(engine: mockNetworkEngine)
    }

    func testDelegateMethodSearchModelDidFetchGraves() {
        let spyDelegate = SpySearchModelDelegate()
        searchModel.delegate = spyDelegate
        let asyncExpectation = expectation(description: "SearchModel calls the delegate as the result of an async method completion")
        spyDelegate.asyncExpectation = asyncExpectation
        searchModel.fetchGraves(with: "kowalski")
        wait(for: [asyncExpectation], timeout: 2)
        guard let result = spyDelegate.searchModelDidFetchedGravesResult else {
            XCTFail("Expected delegate to be called")
            return
        }
        XCTAssertTrue(result.count == 3)
    }
}
