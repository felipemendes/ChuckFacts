//
//  Fact.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 25/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

struct Fact: Codable {
    let identifier: String
    let iconUrl: URL
    let categories: [String?]
    let url: URL
    let value: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case iconUrl = "icon_url"
        case categories = "categories"
        case url = "url"
        case value = "value"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        identifier = try container.decode(String.self, forKey: .identifier)
        iconUrl = try container.decode(URL.self, forKey: .iconUrl)
        categories = try container.decode([String].self, forKey: .categories)
        url = try container.decode(URL.self, forKey: .url)
        value = try container.decode(String.self, forKey: .value)
    }
}
