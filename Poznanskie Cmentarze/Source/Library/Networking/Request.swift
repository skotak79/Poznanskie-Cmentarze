//
//  Request.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 14/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation

public enum HttpMethod {
    case get

    var value: String {
        switch self {
        case .get: return "GET"
        }
    }
}

public protocol Request {
    associatedtype ResponseType: Decodable

    var baseURL: URL { get }
    var allHTTPHeaderFields: [String: String]? { get }
    var parameters: [String: String]? { get }
    var path: String? { get }
    var method: HttpMethod { get }

    static func decode(with data: Data) throws -> ResponseType
    func buildURLRequest() -> URLRequest?
}

extension Request {
    public static func decode(with data: Data) throws -> ResponseType {
        return try JSONDecoder().decode(ResponseType.self, from: data)
    }

    public func buildURLRequest() -> URLRequest? {

        let url = self.path.map({ self.baseURL.appendingPathComponent($0) }) ?? self.baseURL
        guard var component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            assertionFailure()
            return nil
        }
        if let parameters = self.parameters {
            component.queryItems = parameters.map {
                URLQueryItem(name: $0, value: $1)}
        }
        guard let resolvedUrl = component.url else {
            assertionFailure()
            return nil
        }
        var request = URLRequest(url: resolvedUrl)
        request.httpMethod = self.method.value
        return request
    }

    public var method: HttpMethod {
        return .get
    }
}
