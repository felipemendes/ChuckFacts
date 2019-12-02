//
//  Encodable.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 30/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

public protocol Encodable {
    func encode(urlRequest: inout URLRequest, with parameters: [String: String]) throws
}
