//
//  FactEndpoint.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 28/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

enum Request: RequestType {

    case random
    case randomWithCategory(category: String)
    case categories
    case search(keyword: String)

    var environmentBaseURL: String {
        switch ServiceManager.environment {
        case .production:
            return "https://api.chucknorris.io/jokes/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("Service: API URL not found!")
        }
        return url
    }

    var path: String {
        switch self {
        case .random:
            return "random"
        case .randomWithCategory(let category):
            return "random?category=\(category)"
        case .categories:
            return "categories"
        case .search(let keyword):
            return "search?query=\(keyword)"
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        return .request
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
