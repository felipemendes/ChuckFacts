//
//  RequestType.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 28/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol RequestType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
}
