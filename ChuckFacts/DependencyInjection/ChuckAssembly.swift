//
//  ChuckAssembly.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 25/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Swinject

public class ChuckAssembly: Assembly {

    public func assemble(container: Container) {
        container.register(FlowController.self) { (resolver: Resolver, navigationController: UINavigationController) in
            let factory = resolver.resolve(Factory.self)!
            return FlowController(navigationController: navigationController,
                                  factory: factory)
        }

        // MARK: - Factory

        container.register(Factory.self) { resolver in
            return FactoryImplementation(resolver: resolver)
        }

        // MARK: - ServiceManager

        container.register(ServiceManager.self) { _ in
            return ServiceManager()
        }

        // MARK: - HomeViewController

        container.register(HomeViewModel.self) { (resolver, keyword: String) in
            let serviceManager = resolver.resolve(ServiceManager.self)!
            return HomeViewModel(keyword: keyword, serviceManager: serviceManager)
        }

        container.register(HomeViewController.self) { (resolver, keyword: String) in
            let viewModel = resolver.resolve(HomeViewModel.self, argument: keyword)!
            return HomeViewController(keyword: keyword, viewModel: viewModel)
        }
    }
}
