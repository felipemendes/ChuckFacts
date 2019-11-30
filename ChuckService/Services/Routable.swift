//
//  Routable.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 28/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

public typealias RouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

protocol Routable: class {
    associatedtype Endpoint: EndpointType
    func request(_ route: Endpoint, completion: @escaping RouterCompletion)
    func cancel()
}
