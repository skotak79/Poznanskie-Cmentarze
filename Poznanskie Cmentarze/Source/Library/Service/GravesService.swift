//
//  GravesService.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

enum GraveSearchCategory {
    case regular(name: String, surname: String)
    case surnameOnly(surname: String)
    case unique(surnameName: String, id: Int)
}

import Foundation
final class GravesService {
    private let baseUrl = URL(string: "http://www.poznan.pl/featureserver/featureserver.cgi/groby")!
    private let networking: Networking
    private var tasks: [URLSessionTask?] = []

    init(networking: Networking) {
        self.networking = networking
    }

    /// Search graves for given name
    ///
    /// - Parameters:
    ///   - name
    ///   - completion: called when operation finishes
    /// - Returns: Void
    func search(name: Name, completion: @escaping (Result<[Grave]>) -> Void) {

        let parametersArray = getParametersArray(forName: name)
        let resources = parametersArray.map {Resource.init(url: baseUrl, parameters: $0)}

        fetchGraves(with: resources, completion)
    }

    func cancelSearch() {
        tasks.forEach {$0?.cancel()}
    }

    private func fetchGraves(with resources: [Resource], _ completion: @escaping (Result<[Grave]>) -> Void) {

        var storedError: LoadingError?
        let errorSyncQueue = DispatchQueue(label: "FetchGraves.ErrorSync")
        let downloadGroup = DispatchGroup()
        let graveCollection = GraveCollection()

        cancelSearch()

        for resource in resources {
            downloadGroup.enter()
            self.tasks.append(self.networking.fetch(resource: resource, completion: { result in
                switch result {
                case .success(let data):
                    do {
                        let graves = try GraveListResponse.make(data: data)?.features ?? []
                        graveCollection.add(graves: graves)
                    } catch {
                        errorSyncQueue.sync {
                            storedError = LoadingError.decodingError
                        }
                    }
                case .failure(let error):
                    errorSyncQueue.sync {
                        storedError = error
                    }
                }
                downloadGroup.leave()
            }))
        }

        downloadGroup.notify(queue: DispatchQueue.main) {
            if let storedError = storedError {
                completion(Result.failure(storedError))
            } else {
                completion(Result.success(graveCollection.graves))
            }
        }
    }

    private func getParametersArray(forName name: Name) -> [[String: String]] {

        if !name.firstName.isEmpty {
            return [
                getParameters(for: .regular(name: name.firstName, surname: name.surname)),
                getParameters(for: .unique(surnameName: "\(name.surname) \(name.firstName)", id: IdsForUniqueCemeteries.lubowska)),
                getParameters(for: .unique(surnameName: "\(name.surname) \(name.firstName)", id: IdsForUniqueCemeteries.samotna))
            ]
        } else {
            return [getParameters(for: .surnameOnly(surname: name.surname))]
        }
    }

    /// make parameters for given grave search category
    private func getParameters(for category: GraveSearchCategory) -> [String: String] {
        var parameters: [String: String] = [:]
        parameters.updateValue(String(Config.maxGraves), forKey: "maxFeatures")
        parameters.updateValue("g_surname_name,cm_id", forKey: "queryable")
        switch category {
        case .surnameOnly(let surname):
            parameters.updateValue(surname, forKey: "g_surname")
            parameters.updateValue("g_surname", forKey: "queryable")
        case .regular(let name, let surname):
            parameters.updateValue(surname, forKey: "g_surname")
            parameters.updateValue(name, forKey: "g_name")
            parameters.updateValue("g_name,g_surname", forKey: "queryable")
        case .unique(let surnameName, let id):
            parameters.updateValue(surnameName, forKey: "g_surname_name")
            parameters.updateValue(String(describing: id), forKey: "cm_id")
        }
        return parameters
    }
}

private class GraveListResponse: Decodable {
    let features: [Grave]
    static func make(data: Data) throws -> GraveListResponse? {
        return try JSONDecoder().decode(GraveListResponse.self, from: data)
    }
}

private enum Config {
    static let maxGraves = 100
}
