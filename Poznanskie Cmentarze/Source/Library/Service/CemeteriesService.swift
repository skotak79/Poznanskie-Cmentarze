//
//  CemeteriesService.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation

final class CemeteriesService {
    private let baseUrl = URL(string: "http://www.poznan.pl/featureserver/featureserver.cgi/cmentarze")!
    private let networking: Networking

    // used to identify cemetery of the grave
    static var cemeteryIdsWithNames: [Int: String]!
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    /// Fetch all cemeteries
    ///
    /// - Parameter completion: Called when operation finishes
    func fetchAll(completion: @escaping (Result<[Cemetery]>) -> Void) {
        let resource = Resource(url: baseUrl, path: "all.json")
        _ = networking.fetch(resource: resource, completion: { result in
                switch result {
                case .success(let data):
                    do {
                        let cemeteries = try CemeteryListResponse.make(data: data)?.features ?? []
                        CemeteriesService.cemeteryIdsWithNames = Dictionary(uniqueKeysWithValues: cemeteries.map {
                            ($0.id, $0.name)})
                        completion(.success(cemeteries))
                    } catch {
                        completion(.failure(.decodingError))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        })
    }
}

private class CemeteryListResponse: Decodable {
    let features: [Cemetery]
    static func make(data: Data) throws -> CemeteryListResponse? {
            return try JSONDecoder().decode(CemeteryListResponse.self, from: data)
        }
}
