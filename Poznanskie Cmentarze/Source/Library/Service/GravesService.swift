//
//  GravesService.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

enum GraveSearchCategory {
    case regular(name: String, surname: String)
    case surname(surname: String)
    case lubowska(surnameName: String)
    case samotna(surnameName: String)
}

import Foundation
final class GravesService {
    private let baseUrl = URL(string: "http://www.poznan.pl/featureserver/featureserver.cgi/groby")!
    private let networking: Networking
    private var tasks: [URLSessionTask?] = []
    private let concurrentGraveQueue = DispatchQueue(label: "graveQueue", attributes: .concurrent)
    private var tempGraves: [Grave] = []
    var graves: [Grave] {
        var gravesCopy: [Grave]!
        concurrentGraveQueue.sync {
            gravesCopy = self.tempGraves
        }
        return gravesCopy
    }

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
        var storedError: LoadingError?
        var parametersArray = [[String: String]]()

        tasks.forEach {$0?.cancel()}
        tempGraves.removeAll()

        if !name.firstName.isEmpty {
            parametersArray = [
                parameters(for: .regular(name: name.firstName, surname: name.surname)),
                parameters(for: .lubowska(surnameName: "\(name.surname) \(name.firstName)")),
                parameters(for: .samotna(surnameName: "\(name.surname) \(name.firstName)"))
            ]
        } else {
            parametersArray = [parameters(for: .surname(surname: name.surname))]
        }
        let resources = parametersArray.map {Resource.init(url: baseUrl, parameters: $0)}

        let downloadGroup = DispatchGroup()

        for resource in resources {
            downloadGroup.enter()
            self.tasks.append(self.networking.fetch(resource: resource, completion: { result in
                switch result {
                case .success(let data):
                    do {
                        let graves = try GraveListResponse.make(data: data)?.features ?? []
                        self.addGraves(graves: graves)
                    } catch {
                        storedError = LoadingError.decodingError
                    }
                case .failure(let error):
                    print("error --------")
                    storedError = error
                }
                print("downloadGroup leave")
                downloadGroup.leave()
            }))
        }

        downloadGroup.notify(queue: DispatchQueue.main) {
            if storedError != nil {
                completion(Result.failure(storedError!))
            } else {
                completion(Result.success(self.graves))
            }
        }
    }
    /// Safe method to add graves
    private func addGraves(graves: [Grave]) {
        concurrentGraveQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else {
                return
            }
            self.tempGraves += graves
        }
    }

    /// make parameters for given grave search category
    private func parameters(for category: GraveSearchCategory) -> [String: String] {
        var parameters = [String: String]()
        parameters.updateValue(String(Config.maxGraves), forKey: "maxFeatures")
        parameters.updateValue("g_surname_name,cm_id", forKey: "queryable")
        switch category {
        case .surname(let surname):
            parameters.updateValue(surname, forKey: "g_surname")
            parameters.updateValue("g_surname", forKey: "queryable")
        case .regular(let name, let surname):
            parameters.updateValue(surname, forKey: "g_surname")
            parameters.updateValue(name, forKey: "g_name")
            parameters.updateValue("g_name,g_surname", forKey: "queryable")
        case .lubowska(let surnameName):
            parameters.updateValue(surnameName, forKey: "g_surname_name")
            parameters.updateValue(String(describing: IdsForUniqueCemeteries.lubowska), forKey: "cm_id")
        case .samotna(let surnameName):
            parameters.updateValue(surnameName, forKey: "g_surname_name")
            parameters.updateValue(String(describing: IdsForUniqueCemeteries.samotna), forKey: "cm_id")
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
