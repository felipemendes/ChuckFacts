//
//  Factory.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 25/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

public protocol Factory {

    // Builds a HomeViewController
    ///
    /// - Returns: An instantiated HomeViewController
    func makeHomeViewController() -> HomeViewController

    // Builds a SearchViewController
    ///
    /// - Returns: An instantiated SearchViewController
    func makeSearchViewController() -> SearchViewController
}
