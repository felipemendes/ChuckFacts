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

    func testUrlBuildWithSingleParameter() {
        let url = URL(string: "https://api.chucknorris.io/jokes/search")!
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
        let url = URL(string: "https://api.chucknorris.io/jokes/search")!
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

    func testUrlBuildWithMultipleParameters() {
        let url = URL(string: "https://sampleurl")!
        var urlRequest = URLRequest(url: url)

        let parameters: [String: String] = [
            "param1": "sample 1",
            "param2": "test2",
            ]

        let encoder = URLParameterEncoder()
        try? encoder.encode(urlRequest: &urlRequest, with: parameters)
        guard let fullURL = urlRequest.url else {
            XCTAssertTrue(false, "Nil URL.")
            return
        }

        let expectedURL = "https://sampleurl?param1=sample%201&param2=test2"
        XCTAssertEqual(fullURL.absoluteString, expectedURL)
    }

}
