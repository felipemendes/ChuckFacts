//
//  Router.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 28/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

class Router<Endpoint: RequestType>: Routable {

    private var task: URLSessionTask?

    func request(_ route: Endpoint, completion: @escaping RouterCompletion) {
        let session = URLSession.shared

        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }

    private func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        var request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)

        request.httpMethod = endpoint.httpMethod.rawValue

        switch endpoint.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .requestParameters(let parameters):
            try self.configureParameters(request: &request,
                                         parameters: parameters)
        }

        return request
    }

    // MARK: - HELPERS

    fileprivate func configureParameters(request: inout URLRequest,
                                         parameters: [String: Any]) throws {
        do {
            try URLParameterEncoder().encode(urlRequest: &request, with: parameters)
        } catch {
            throw error
        }
    }
}