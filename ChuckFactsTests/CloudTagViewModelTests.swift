//
//  CloudTagViewModelTests.swift
//  ChuckFactsTests
//
//  Created by Felipe Mendes on 08/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import XCTest
@testable import ChuckFacts

class CloudTagViewModelTests: XCTestCase {

    func testShuffleAndRandomizeMultipleCollections() throws {
        let firstAmount = 8
        let secondAmount = 10
        //let secondAmount = 10000

        let items = ["animal", "career", "celebrity", "dev", "explicit", "fashion", "food", "history", "money", "movie", "music", "political", "religion", "science", "sport", "travel"]

        let itemsShuffledOnce = items.shuffled(by: firstAmount)
        let itemsShuffledTwice = items.shuffled(by: secondAmount)

        XCTAssertNotNil(itemsShuffledOnce)
        XCTAssertNotNil(itemsShuffledTwice)

        XCTAssertEqual(itemsShuffledOnce.count, firstAmount)
        XCTAssertEqual(itemsShuffledTwice.count, secondAmount)

        XCTAssertNotEqual(itemsShuffledOnce, itemsShuffledTwice)
    }

    func testShuffleAndRandomizeCollectionsWithHigherAmount() throws {
        let amount = 10000
        let itemsCount = 16

        let items = ["animal", "career", "celebrity", "dev", "explicit", "fashion", "food", "history", "money", "movie", "music", "political", "religion", "science", "sport", "travel"]

        let itemsShuffled = items.shuffled(by: amount)

        XCTAssertNotNil(itemsShuffled)
        XCTAssertEqual(itemsShuffled.count, itemsCount)
    }
}
