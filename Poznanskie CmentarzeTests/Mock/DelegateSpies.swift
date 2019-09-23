//
//  DelegateSpies.swift
//  Poznanskie CmentarzeTests
//
//  Created by Wojtek Skotak on 21/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import XCTest
@testable import Poznanskie_Cmentarze

class SpyCemeteryModelDelegate: CemeteryModelDelegate {

    var cemeteryModelDidFetchedCemeteriesResult: [Cemetery]?
    var asyncExpectation: XCTestExpectation?

    func cemeteryModel(_ cemeteryModel: CemeteryModel, didFetchedCemeteries cemeteries: [Cemetery]) {
        guard let expectation = asyncExpectation else {
            XCTFail("Spy delegate was not setup correctly. Missing XCTEpectation reference.")
            return
        }
        cemeteryModelDidFetchedCemeteriesResult = cemeteries
        expectation.fulfill()
    }
}

class SpySearchModelDelegate: SearchModelDelegate {

    var searchModelDidFetchedGravesResult: [Grave]?
    var asyncExpectation: XCTestExpectation?

    func searchModel(_ searchModel: SearchModel, didReceive error: LoadingError) {}

    func searchModel(_ searchModel: SearchModel, didChange isFetchingGraves: Bool) {}

    func searchModel(_ searchModel: SearchModel, didFetched graves: [Grave]) {
        guard let expectation = asyncExpectation else {
            XCTFail("Spy delegate was not setup correctly. Missing XCTEpectation reference.")
            return
        }
        searchModelDidFetchedGravesResult = graves
        print("Graves w spider: \(graves.count)")
        expectation.fulfill()
    }
}
