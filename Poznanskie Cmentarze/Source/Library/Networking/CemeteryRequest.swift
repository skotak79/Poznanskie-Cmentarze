//
//  CemeteryRequest.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation

public struct CemeteryRequest: Request {

    public typealias ResponseType = CemeteryListResponse?
    public var parameters: [String: String]?
    public var path: String?
    public var baseURL: URL
    public var allHTTPHeaderFields: [String: String]?

    public init() {
        baseURL = URL(string: "http://www.poznan.pl/featureserver/featureserver.cgi/cmentarze")!
        path = "all.json"
    }
}

public class CemeteryListResponse: Decodable {
    let features: [Cemetery]
    static func make(data: Data) throws -> CemeteryListResponse? {
        return try JSONDecoder().decode(CemeteryListResponse.self, from: data)
    }
}
