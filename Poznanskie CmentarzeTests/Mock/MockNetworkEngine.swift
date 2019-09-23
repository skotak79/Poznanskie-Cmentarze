//
//  MockNetworkEngine.swift
//  Poznanskie CmentarzeTests
//
//  Created by Wojtek Skotak on 17/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import XCTest
@testable import Poznanskie_Cmentarze

final class MockNetworkEngine: NetworkEngine {
    let data: Data

    init(fileName: String) {
        let bundle = Bundle(for: MockNetworkEngine.self)
        let url = bundle.url(forResource: fileName, withExtension: "json")!
        // swiftlint:disable force_try
        self.data = try! Data(contentsOf: url)
    }

    func send<T>(_ request: T, completion: @escaping ((Result<T.ResponseType>) -> Void)) -> URLSessionTask? where T: Request {
        var decoded: T.ResponseType?
        do {
            decoded = try T.decode(with: data)
        } catch _ {}
        completion(.success(decoded!))
        return nil
    }
}
