//
//  MockNetworkService.swift
//  Poznanskie CmentarzeTests
//
//  Created by Wojtek Skotak on 20.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation
@testable import Poznanskie_Cmentarze

final class MockNetworkService: Networking {
    let data: Data
    init(fileName: String) {
        let bundle = Bundle(for: MockNetworkService.self)
        let url = bundle.url(forResource: fileName, withExtension: "json")!
        // swiftlint:disable force_try
        self.data = try! Data(contentsOf: url)
    }
    
    func fetch(resource: Resource, completion: @escaping (Result<Data>) -> Void) -> URLSessionTask? {
        completion(Result.success(data))
        return nil
    }
}
