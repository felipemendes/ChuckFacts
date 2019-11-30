//
//  ServiceTests.swift
//  ChuckFactsTests
//
//  Created by Felipe Mendes on 30/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import XCTest
@testable import ChuckFacts

class ServiceTests: XCTestCase {

    let url = URL(string: "https://api.chucknorris.io/jokes/search")!

    func testUrlBuildWithSingleParameter() {
        var urlRequest = URLRequest(url: url)

        let encoder = URLParameterEncoder()
        try? encoder.encode(urlRequest: &urlRequest, with: ["query": "Brazil"])
        guard let fullURL = urlRequest.url else {
            XCTAssertTrue(false, "Nil URL.")
            return
        }

        let expectedURL = "https://api.chucknorris.io/jokes/search?query=brazil"
        XCTAssertEqual(fullURL.absoluteString, expectedURL)
    }

    func testUrlBuildWithCompoundWordParameter() {
        var urlRequest = URLRequest(url: url)

        let encoder = URLParameterEncoder()
        try? encoder.encode(urlRequest: &urlRequest, with: ["query": "Bruce Lee"])
        guard let fullURL = urlRequest.url else {
            XCTAssertTrue(false, "Nil URL.")
            return
        }

        let expectedURL = "https://api.chucknorris.io/jokes/search?query=bruce%20lee"
        XCTAssertEqual(fullURL.absoluteString, expectedURL)
    }

}
