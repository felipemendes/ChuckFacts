//
//  Manager.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 28/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

enum RequestError: String {
    case taskError = "Network request failed"
    case noData = "No data on API response"
    case invalidJson = "Invalid JSON API response"
}

struct ServiceManager {
    static let environment: Environment = .production
    let router = Router<Request>()

    /// Retrieve a list of available categories.

    func getCategories(completion: @escaping (_ categories: [String]?, _ error: String?) -> Void) {
        router.request(.categories) { data, response, _ in

            if let response = response as? HTTPURLResponse {

                if response.statusCode == 200 {
                    guard let responseData = data else {
                        completion(nil, RequestError.noData.rawValue)
                        return
                    }

                    do {
                        let categoriesResponse = try JSONDecoder().decode([String].self, from: responseData)
                        completion(categoriesResponse, nil)
                    } catch {
                        completion(nil, RequestError.invalidJson.rawValue)
                    }
                }
            } else {
                completion(nil, RequestError.taskError.rawValue)
            }
        }
    }
}
