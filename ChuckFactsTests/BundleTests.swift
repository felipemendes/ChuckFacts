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

    func testFactbWithOnlyOneItemFromStub() throws {
        let bundle = Bundle(for: type(of: self))
        let fact = try bundle.fetchFactBundle(for: "singleFact")

        XCTAssertNotNil(fact)
        XCTAssert(fact?.identifier == "tnr_ylf0tciqndymlnmw5g")
        XCTAssert(fact?.iconUrl.absoluteString == "https://assets.chucknorris.host/img/avatar/chuck-norris.png")
        XCTAssertEqual(fact?.value, "In the Bible, Jesus turned water into wine. But then Chuck Norris turned that wine into beer.")
        XCTAssert(fact?.url.absoluteString == "https://api.chucknorris.io/jokes/tnr_ylf0tciqndymlnmw5g")
    }

    func testFactResponseWithResultsMultipleItemsFromStub() throws {
        let bundle = Bundle(for: type(of: self))
        let factResponse = try bundle.fetchFactResponseBundle(for: "multipleFacts")

        XCTAssert(factResponse?.total == 3)
        XCTAssert(factResponse?.result.count == 3)

        XCTAssert(factResponse?.result[0].identifier == "z0vjwbedqhqfph0mc88skg")
        XCTAssert(factResponse?.result[1].identifier == "XHd6GOm_SEqKq_kNM1ZI8w")
        XCTAssert(factResponse?.result[2].identifier == "qqthrspvtqyigfwvaui2eq")
    }
}
