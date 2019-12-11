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

    private lazy var homeViewController: HomeViewController = {
        let controller = factory.makeHomeViewController()
        return controller
    }()

    private lazy var searchViewController: SearchViewController = {
        let controller = factory.makeSearchViewController()
        return controller
    }()

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
        let home = homeViewController
        home.delegate = self
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationController.pushViewController(home, animated: true)
    }

    private func presentSearch() {
        let search = searchViewController
        search.delegate = self
        navigationController.present(search, animated: true, completion: nil)
    }

    private func presentShareSheet(with message: String) {
        let activityViewController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        navigationController.present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - HomeViewControllerDelegate

extension FlowController: HomeViewControllerDelegate {
    public func homeViewControllerDelegate(_ viewController: UIViewController, didTapShare message: String) {
        presentShareSheet(with: message)
    }

    public func homeViewControllerDelegate(_ viewController: UIViewController, didTapSearch search: UIView?) {
        presentSearch()
    }
}

// MARK: - SearchViewControllerDelegate

extension FlowController: SearchViewControllerDelegate {
    public func searchViewControllerDelegate(_ viewController: UIViewController, didTapSearch keyword: String) {
        navigationController.dismiss(animated: true, completion: nil)
        homeViewController.reloadData(with: keyword)
    }
}
