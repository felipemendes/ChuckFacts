//
//  SearchViewModelTests.swift
//  ChuckFactsTests
//
//  Created by Felipe Mendes on 09/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import XCTest
@testable import ChuckFacts

class SearchViewModelTests: XCTestCase {

    let searchDataAccessProvider = SearchDataAccessProvider()

    func testIfSearchKeywordLengthIsMinimum() throws {
        let viewModel = SearchViewModel(searchDataAccessProvider: searchDataAccessProvider)

        let minLength = 4
        let keyword = "Git"

        let result = viewModel.check(minLength: minLength, for: keyword)

        XCTAssertEqual(result, true)
    }

    func testIfSearchKeywordLengthIsEnough() throws {
        let viewModel = SearchViewModel(searchDataAccessProvider: searchDataAccessProvider)

        let minLength = 4
        let keyword = "GitHub"

        let result = viewModel.check(minLength: minLength, for: keyword)

        XCTAssertEqual(result, false)
    }
}
