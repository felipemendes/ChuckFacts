//
//  FactResponse.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 25/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

struct FactResponse: Codable {
    let total: Int
    let result: [Fact]

    enum CodingKeys: String, CodingKey {
        case total, result
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        total = try container.decode(Int.self, forKey: .total)
        result = try container.decode([Fact].self, forKey: .result)
    }
}
