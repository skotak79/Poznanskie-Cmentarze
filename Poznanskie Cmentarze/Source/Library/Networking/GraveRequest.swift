//
//  GraveRequest.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation
public struct GraveRequest: Request {

    public typealias ResponseType = GraveListResponse?

    public var baseURL: URL
    public var allHTTPHeaderFields: [String: String]?
    public var parameters: [String: String]?
    public var path: String?

    init(baseURL: URL, parameters: [String: String]) {
        self.baseURL = baseURL
        self.parameters = parameters
    }
}

extension GraveRequest {
    private enum GraveSearchCategory {
        case regular(name: String, surname: String)
        case surnameOnly(surname: String)
        case unique(surnameName: String, id: Int)
    }

    static func makeRequests(for query: String) -> [GraveRequest] {
        let baseUrl = URL(string: "http://www.poznan.pl/featureserver/featureserver.cgi/groby")!
        let name = Name(with: query)
        let parametersArray = getParametersArray(forName: name)
        let requests = parametersArray.map {GraveRequest.init(baseURL: baseUrl, parameters: $0)}
        return requests
    }

    private static func getParametersArray(forName name: Name) -> [[String: String]] {

        if !name.firstName.isEmpty {
            return [
                getParameters(forSearchCategory: .regular(name: name.firstName, surname: name.surname)),
                getParameters(forSearchCategory: .unique(surnameName: "\(name.surname) \(name.firstName)", id: IdsForUniqueCemeteries.lubowska)),
                getParameters(forSearchCategory: .unique(surnameName: "\(name.surname) \(name.firstName)", id: IdsForUniqueCemeteries.samotna))
            ]
        } else {
            return [getParameters(forSearchCategory: .surnameOnly(surname: name.surname))]
        }
    }

    /// make parameters for given grave search category
    private static func getParameters(forSearchCategory category: GraveSearchCategory) -> [String: String] {
        var parameters = [
            "maxFeatures": String(Config.maxGraves)
        ]
        switch category {
        case .surnameOnly(let surname):
            parameters.merge([
                "g_surname": surname,
                "queryable": "g_surname"
                ], uniquingKeysWith: +)
        case .regular(let name, let surname):
            parameters.merge([
                "g_surname": surname,
                "g_name": name,
                "queryable": "g_name,g_surname"
                ], uniquingKeysWith: +)
        case .unique(let surnameName, let id):
            parameters.merge([
                "g_surname_name": surnameName,
                "cm_id": String(describing: id),
                "queryable": "g_surname_name,cm_id"
                ], uniquingKeysWith: +)
        }
        return parameters
    }
}

public class GraveListResponse: Decodable {
    let features: [Grave]
    static func make(data: Data) throws -> GraveListResponse? {
        return try JSONDecoder().decode(GraveListResponse.self, from: data)
    }
}

private enum Config {
    static let maxGraves = 110
}
