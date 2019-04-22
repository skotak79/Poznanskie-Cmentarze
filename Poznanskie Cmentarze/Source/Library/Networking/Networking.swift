//
//  Networking.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation

protocol Networking {
    /// Fetch data from url and parameters query
    ///
    /// - Parameters:
    ///   - url: The url
    ///   - parameters: Parameters as query items
    ///   - completion: Called when operation finishes
    /// - Returns: The data task
    @discardableResult func fetch(resource: Resource, completion: @escaping (Result<Data>) -> Void) -> URLSessionTask?
}
