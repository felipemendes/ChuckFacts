//
//  Fact.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 25/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

public struct Fact: Codable {
    public let identifier: String
    public let iconUrl: URL
    public let categories: [String?]
    public let url: URL
    public let value: String

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case iconUrl = "icon_url"
        case categories = "categories"
        case url = "url"
        case value = "value"
    }
}
