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
    case failureRequest = "API request failure"
    case invalidJson = "Invalid JSON API response"
}

struct ServiceManager {
    static let environment: Environment = .production
    let router = Router<Request>()

    /// Retrieve a random chuck joke in JSON format.

    func getRandom(completion: @escaping (_ fact: Fact?, _ error: String?) -> Void) {

        router.request(.random) { data, response, _ in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, RequestError.taskError.rawValue)
                return
            }

            if response.statusCode != 200 {
                completion(nil, RequestError.failureRequest.rawValue)
                return
            }
            guard let responseData = data else {
                completion(nil, RequestError.noData.rawValue)
                return
            }

            do {
                let randomResponse = try JSONDecoder().decode(Fact.self, from: responseData)
                completion(randomResponse, nil)
            } catch {
                completion(nil, RequestError.invalidJson.rawValue)
            }
        }
    }

    /// Retrieve a random chuck norris joke from a given category.

    func getRandomWith(category categoryName: String,
                       completion: @escaping (_ fact: Fact?, _ error: String?) -> Void) {

        router.request(.randomWithCategory(category: categoryName)) { data, response, _ in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, RequestError.taskError.rawValue)
                return
            }

            if response.statusCode != 200 {
                completion(nil, RequestError.failureRequest.rawValue)
                return
            }
            guard let responseData = data else {
                completion(nil, RequestError.noData.rawValue)
                return
            }

            do {
                let randomResponse = try JSONDecoder().decode(Fact.self, from: responseData)
                completion(randomResponse, nil)
            } catch {
                completion(nil, RequestError.invalidJson.rawValue)
            }
        }
    }

    /// Retrieve a list of available categories.

    func getCategories(completion: @escaping (_ categories: [String]?, _ error: String?) -> Void) {

        router.request(.categories) { data, response, _ in
            guard let response = response as? HTTPURLResponse else {
                completion(nil, RequestError.taskError.rawValue)
                return
            }

            if response.statusCode != 200 {
                completion(nil, RequestError.failureRequest.rawValue)
                return
            }
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
    }
}
