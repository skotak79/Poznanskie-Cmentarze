//
//  CemeteryModelTests.swift
//  Poznanskie CmentarzeTests
//
//  Created by Wojtek Skotak on 21/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import XCTest
@testable import Poznanskie_Cmentarze

class CemeteryModelTests: XCTestCase {

    var cemeteryModel: CemeteryModel!

    override func setUp() {
        let mockNetworkEngine = MockNetworkEngine(fileName: "cemeteries")
        cemeteryModel = CemeteryModel(engine: mockNetworkEngine)
    }

    func testDelegateMethodModelDidFetchCemeteries() {
        let spyDelegate = SpyCemeteryModelDelegate()
        cemeteryModel.delegate = spyDelegate
        let asyncExpectation = expectation(description: "CemeteryModel calls the delegate as the result of an async method completion")
        spyDelegate.asyncExpectation = asyncExpectation
        cemeteryModel.fetchAll(completion: {_ in })
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeOut errored: \(error)")
            }
            guard let result = spyDelegate.cemeteryModelDidFetchedCemeteriesResult else {
                XCTFail("Expected delegate to be called")
                return
            }
            XCTAssertTrue(result.count == 20)
        }
    }

    func testFetchAll() {
        let expectation = self.expectation(description: #function)
        cemeteryModel.fetchAll(completion: { result in
            switch result {
            case Result.failure(_):
                XCTFail("Resulted with Error")
            case Result.success(let cemeteries):
                XCTAssertEqual(cemeteries.count, 20)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 1)
    }
}
