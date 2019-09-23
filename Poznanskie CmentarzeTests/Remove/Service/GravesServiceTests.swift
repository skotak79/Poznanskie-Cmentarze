////
////  GravesService.swift
////  Poznanskie CmentarzeTests
////
////  Created by Wojtek Skotak on 20.11.2018.
////  Copyright © 2018 Wojtek Skotak. All rights reserved.
////
//
//import XCTest
//@testable import Poznanskie_Cmentarze
//
//class GravesServiceTests: XCTestCase {
//    func testSearch() {
//        let expectation = self.expectation(description: #function)
//        let mockNetworkService = MockNetworkService(fileName: "graves")
//        let gravesService = GravesService(networking: mockNetworkService)
//
//        gravesService.search(name: Name(firstName: "", surname: "Nowak"), completion: { result in
//            switch result {
//            case Result.failure(_):
//                XCTFail("Resulted with Error")
//            case Result.success(let graves):
//                XCTAssertEqual(graves.count, 3)
//                expectation.fulfill()
//            }
//        })
//        wait(for: [expectation], timeout: 1)
//    }
//}
