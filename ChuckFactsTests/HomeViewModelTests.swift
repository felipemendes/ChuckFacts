//
//  HomeViewModelTests.swift
//  ChuckFactsTests
//
//  Created by Felipe Mendes on 06/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import XCTest
@testable import ChuckFacts

class HomeViewModelTests: XCTestCase {

    let serviceManger = ServiceManager()

    func testPreferredTypographyToApplyBiggerThan80() throws {
        let bundle = Bundle(for: type(of: self))
        let fact = try bundle.fetchFactBundle(for: "singleFactWithValueLenghtBiggerThan80")
        let viewModel = HomeViewModel(serviceManager: serviceManger)

        let preferredTypography = viewModel.retrievePreferredTypography(for: (fact?.value)!)
        XCTAssertEqual(preferredTypography, Guideline.Typography.subtitle(weight: .semibold))
    }

    func testPreferredTypographyToApplySmallerThan80() throws {
        let bundle = Bundle(for: type(of: self))
        let fact = try bundle.fetchFactBundle(for: "singleFactWithValueLenghtSmallerThan80")
        let viewModel = HomeViewModel(serviceManager: serviceManger)

        let preferredTypography = viewModel.retrievePreferredTypography(for: (fact?.value)!)
        XCTAssertEqual(preferredTypography, Guideline.Typography.title(weight: .semibold))
    }
}
