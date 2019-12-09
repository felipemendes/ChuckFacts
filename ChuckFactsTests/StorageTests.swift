//
//  StorageTests.swift
//  ChuckFactsTests
//
//  Created by Felipe Mendes on 02/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import XCTest
@testable import ChuckFacts

class StorageTests: XCTestCase {

    let serviceManager = ServiceManager()
    let searchDataAccessProvider = SearchDataAccessProvider()

    func testAddNewSearchKeywordIntoDataModel() throws {
        let newKeyword = "Animal"

        let searchViewModel = SearchViewModel(serviceManager: serviceManager, searchDataAccessProvider: searchDataAccessProvider)
        searchViewModel.addSearch(keyword: newKeyword)

        let retrievedData = searchViewModel.retrieveSearches().value
        let existence = retrievedData.map { $0.keyword == newKeyword }.count > 0

        XCTAssertNotNil(retrievedData)
        XCTAssertEqual(existence, true)
    }

    func testIfKeywordIsDuplicatedAddedIntoDataModel() throws {
        let newKeyword = "Dev"
        let sameKeyword = "Dev"

        let searchViewModel = SearchViewModel(serviceManager: serviceManager, searchDataAccessProvider: searchDataAccessProvider)

        searchViewModel.addSearch(keyword: newKeyword)
        searchViewModel.addSearch(keyword: sameKeyword)

        let retrievedData = searchViewModel.retrieveSearches().value
        let existence = retrievedData.map { $0.keyword == newKeyword }.count > 0

        XCTAssertEqual(existence, true)
    }
}
