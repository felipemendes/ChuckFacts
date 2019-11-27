//
//  FactResponse.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 25/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

public struct FactResponse: Codable {
    public let total: Int
    public let result: [Fact]
}
