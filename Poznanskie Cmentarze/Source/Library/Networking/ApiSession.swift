//
//  ApiSession.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 11/09/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//
import Foundation
import SystemConfiguration

public enum Result<Value> {
    case success(Value)
    case failure(LoadingError)
}

public enum LoadingError: Error {
    case networkUnavailable
    case timedOut
    case invalidStatusCode(code: Int)
    case requestMakingFailure
    case serverFailure
    case decodingError
    case emptyData

    func errorMessage() -> String {
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
        case .emptyData:
            return "Brak danych"
        default:
            return "Inny błąd"
        }
    }
}

public protocol NetworkEngine {
    typealias Handler<T: Request> = (Result<T.ResponseType>) -> Void

    func send<T: Request>(_ request: T, completion: @escaping (Handler<T>)) -> URLSessionTask?
}

public final class ApiSession: NetworkEngine {

    private let session: URLSession
    private let configuration: URLSessionConfiguration
    private let reachability = SCNetworkReachabilityCreateWithName(nil, "www.poznan.pl")

    public init(configuration: URLSessionConfiguration = .default) {
        configuration.timeoutIntervalForRequest = 30
        self.configuration = configuration
        self.session = URLSession(configuration: configuration)
    }

    public func send<T: Request>(_ request: T, completion: @escaping (Result<T.ResponseType>) -> Void) -> URLSessionTask? {
        let urlRequest = request.buildURLRequest()!
        print(urlRequest.url!)
        let task = session.dataTask(with: urlRequest) { [weak self] data, _, error in

            guard let self = self, self.isNetworkReachable() else {
                completion(Result.failure(LoadingError.networkUnavailable))
                return
            }

            if let error = error {
                debugPrint("DataTask error: \(error.localizedDescription)")
                completion(.failure(.serverFailure))
            }

            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }

            do {
                try completion(.success(T.decode(with: data)))
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(LoadingError.decodingError))
            }
        }
        task.resume()
        return task
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

extension ApiSession {
    static let shared: ApiSession = {
        return ApiSession()
    }()
}
