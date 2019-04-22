//
//  CemeteriesService.swift
//  Poznanskie CmentarzeTests
//
//  Created by Wojtek Skotak on 20.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import XCTest
@testable import Poznanskie_Cmentarze

class CemeteriesServiceTest: XCTestCase {
    func testFetchAll() {
        let expectation = self.expectation(description: #function)
        let mockNetworkService = MockNetworkService(fileName: "cemeteries")
        let cemeteriesService = CemeteriesService(networking: mockNetworkService)
         cemeteriesService.fetchAll(completion: { result in
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
