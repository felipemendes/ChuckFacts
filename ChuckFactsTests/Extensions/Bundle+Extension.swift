//
//  Bundle+Extension.swift
//  ChuckFactsTests
//
//  Created by Felipe Mendes on 26/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

extension Bundle {
    func fetchFactBundle(for resource: String) throws -> Fact? {
        guard let url = self.url(forResource: resource, withExtension: "json") else {
            return nil
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()

        return try decoder.decode(Fact.self, from: data)
    }

    func fetchFactResponseBundle(for resource: String) throws -> FactResponse? {
        guard let url = self.url(forResource: resource, withExtension: "json") else {
            return nil
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()

        return try decoder.decode(FactResponse.self, from: data)
    }
}
