//
//  FlowController.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 24/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

public class FlowController {

    // MARK: - PRIVATE PROPERTIES

    private let factory: Factory

    // MARK: - INITIALIZER

    public init(navigationController: UINavigationController,
                factory: Factory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    // MARK: - PUBLIC API

    /// This navigation controller holds all internal UIViewControllers
    /// that will be stack over app execution.
    public let navigationController: UINavigationController

    /// Starts the main flow. This will setup the internal Home Controller and
    /// push it into navigation controller.
    public func start() {
        presentHome()
    }

    private func presentHome() {
        let homeContainer = factory.makeHomeViewController(keyword: "Brazil")
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.pushViewController(homeContainer, animated: true)
    }
}
