//
//  FactoryImplementation.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 25/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Swinject

public class FactoryImplementation: Factory {

    // MARK: - PRIVATE PROPERTIES

    private let resolver: Resolver

    // MARK: - PUBLIC API

    public init(resolver: Resolver) {
        self.resolver = resolver
    }

    // MARK: - FACTORY

    public func makeHomeViewController() -> HomeViewController {
        return resolver.resolve(HomeViewController.self)!
    }

    public func makeSearchViewController() -> SearchViewController {
        return resolver.resolve(SearchViewController.self)!
    }
}
