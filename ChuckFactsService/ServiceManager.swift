//
//  Manager.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 28/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

// MARK: - ENUM

enum RequestError: String {
    case taskError = "Network request failed"
    case noData = "No data on API response"
    case failureRequest = "API request failure"
    case invalidJson = "Invalid JSON API response"
}

public struct ServiceManager {

    // MARK: - PROPERTIES

    static let environment: Environment = .production
    let router = Router<Request>()

    // MARK: - PUBLIC APIs

    /// Retrieve a random chuck joke in JSON format.
    ///
    /// - Throws: Throws a single Fact response and a error message
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
    ///
    /// - Parameter category: A category text name
    /// - Throws: Throws a single Fact response and a error message
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
    ///
    /// - Throws: Throws a text collection response and a error message
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

    /// Free text search.
    ///
    /// - Parameter keyword: A text type to be searched for in facts
    /// - Throws: Throws a single Fact response and a error message
    func getSearch(from keyword: String, completion: @escaping (_ fact: FactResponse?, _ error: String?) -> Void) {

        router.request(.search(keyword: keyword)) { data, response, _ in
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
                let searchResponse = try JSONDecoder().decode(FactResponse.self, from: responseData)
                completion(searchResponse, nil)
            } catch {
                completion(nil, RequestError.invalidJson.rawValue)
            }
        }
    }
}
