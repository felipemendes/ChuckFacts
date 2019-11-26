//
//  BundleTests.swift
//  ChuckFactsTests
//
//  Created by Felipe Mendes on 26/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import XCTest
@testable import ChuckFacts

class BundleTests: XCTestCase {

    func testBundleFacts() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "fact", withExtension: "json") else {
            XCTFail("Missing file: fact.json")
            return
        }

        let json = try Data(contentsOf: url)
        let data = try JSONSerialization.data(withJSONObject: json, options: [])
        let decoder = JSONDecoder()
        let fact = try decoder.decode(Fact.self, from: data)

        XCTAssertEqual(fact.identifier, "tnr_ylf0tciqndymlnmw5g")
    }

}
