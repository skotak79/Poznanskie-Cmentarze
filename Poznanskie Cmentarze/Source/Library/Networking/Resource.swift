//
//  Resource.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import Foundation

// A network resource, identified by url and parameters
struct Resource {
    let url: URL
    let path: String?
    let httpMethod: String
    let parameters: [String: String]
    init(url: URL, path: String? = nil, httpMethod: String = "GET", parameters: [String: String] = [:]) {
        self.url = url
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
    }
}
