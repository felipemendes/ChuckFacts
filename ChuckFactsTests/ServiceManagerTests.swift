//
//  ServiceManagerTests.swift
//  ChuckFactsTests
//
//  Created by Felipe Mendes on 30/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import XCTest
@testable import ChuckFacts

class ServiceManagerTests: XCTestCase {

    let serviceManger = ServiceManager()

    func testRandomFactRequest() {
        serviceManger.getRandom { fact, error in
            XCTAssertNotNil(fact)
            XCTAssertNil(error)
        }
    }

    func testRandomFactWithCategoryRequest() {
        _ = [ "animal", "career", "celebrity", "dev"].map {
            serviceManger.getRandomWith(category: $0) { fact, error in
                XCTAssertNotNil(fact)
                XCTAssertNil(error)
            }
        }
    }

    func testCategoriesRequest() {
        serviceManger.getCategories { categories, error in
            XCTAssertNotNil(categories)
            XCTAssertNil(error)
        }
    }

    func testSearchFactRequest() {
        serviceManger.getSearch(from: "Bruce Lee") { factResponse, error  in
            XCTAssertNotNil(factResponse)
            XCTAssertNil(error)
        }
    }
    
}
