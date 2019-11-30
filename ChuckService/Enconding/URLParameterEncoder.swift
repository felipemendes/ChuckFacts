//
//  URLParameterEncoder.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 30/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

// MARK: - ENUM

enum NetworkError: String, Error {
    case parametersNil = "Parameters not found."
    case encodingFailed = "Encoding parameters failed."
    case missingURL = "URL is nil."
}

public struct URLParameterEncoder: Encodable {

    /// Parameter encoder for building safe URL
    ///
    /// - Parameter urlRequest: A URLRequest
    /// - Parameter parameters: A text tuple of String
    public func encode(urlRequest: inout URLRequest, with parameters: [String: String]) throws {
        guard let url = urlRequest.url else {
            throw NetworkError.missingURL
        }

        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false),
                                             !parameters.isEmpty {

            urlComponents.queryItems = [URLQueryItem]()

            _ = parameters.map {
                let queryItem = URLQueryItem(name: $0, value: "\($1.lowercased())")
                urlComponents.queryItems?.append(queryItem)
            }

            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
