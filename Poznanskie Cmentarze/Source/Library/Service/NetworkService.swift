//
//  NetworkService.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//
enum Result<Value> {
    case success(Value)
    case failure(LoadingError)
}

enum LoadingError: Error {
    case networkUnavailable
    case timedOut
    case invalidStatusCode(code: Int)
    case requestMakingFailure
    case serverFailure
    case decodingError
    
    func makeErrorMessage() -> String {
        switch self {
        case .networkUnavailable:
            return "Brak dostępu do internetu"
        case .timedOut:
            return "Błąd Timed Out"
        case .invalidStatusCode(let code):
            return "Błąd. Status Code: \(code)"
        case .serverFailure:
            return "Błąd. Spróbuj później"
        case .decodingError:
            return "Błąd dekodowania danych. Skontaktuj się z autorem albo uaktualnij aplikację"
        default:
            return "Inny błąd"
        }
    }
}

import Foundation
import SystemConfiguration

final class NetworkService: Networking {
    private let session: URLSession

    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.poznan.pl")
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration)
    }
    @discardableResult func fetch(resource: Resource, completion: @escaping (Result<Data>) -> Void) -> URLSessionTask? {
        guard let request = makeRequest(resource: resource) else {
            completion(.failure(.requestMakingFailure))
            return nil
        }
        print(request.url!.absoluteString)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard self.isNetworkReachable() else {
                completion(Result.failure(LoadingError.networkUnavailable))
                return
            }
            // serch was cancelled
            if let error = error as NSError?, error.code == -999 {
                return
            }
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(.serverFailure))
                return
            }
            if 200 ..< 300 ~= response.statusCode {
                completion(.success(data))
                return
            } else if 400 ..< 500 ~= response.statusCode {
                completion(.failure(.invalidStatusCode(code: response.statusCode)))
                return
            } else {
                print("Response statuscode \(response.statusCode)")
                completion(.failure(.serverFailure))
                print(error.debugDescription )
                return
            }
        })
        task.resume()
        return task
    }
    /// Convenient method to make request
    ///
    /// - Parameters:
    ///   - resource: Network resource
    /// - Returns: Constructed URL request
    private func makeRequest(resource: Resource) -> URLRequest? {
        let url = resource.path.map({ resource.url.appendingPathComponent($0) }) ?? resource.url
        guard var component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            assertionFailure()
            return nil
        }
        component.queryItems = resource.parameters.map({
            return URLQueryItem(name: $0, value: $1)
        })
        guard let resolvedUrl = component.url else {
            assertionFailure()
            return nil
        }
        var request = URLRequest(url: resolvedUrl)
        request.httpMethod = resource.httpMethod
        return request
    }
    private func isNetworkReachable() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(self.reachability!, &flags)
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserIntervention = canConnectAutomatically && !flags.contains(.interventionRequired)

        return isReachable && (!needsConnection || canConnectWithoutUserIntervention)
    }
}
