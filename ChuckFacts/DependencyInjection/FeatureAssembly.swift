//
//  FeatureAssembly.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 25/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Swinject

public class FeatureAssembly: Assembly {

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

        // MARK: - HomeViewController

        container.register(HomeViewModel.self) { resolver in
            let serviceManager = resolver.resolve(ServiceManager.self)!
            return HomeViewModel(serviceManager: serviceManager)
        }

        container.register(HomeViewController.self) { resolver in
            let viewModel = resolver.resolve(HomeViewModel.self)!
            return HomeViewController(viewModel: viewModel)
        }

        // MARK: - SearchViewController

        container.register(SearchViewModel.self) { resolver in
            let serviceManager = resolver.resolve(ServiceManager.self)!
            let searchDataAccessProvider = resolver.resolve(SearchDataAccessProvider.self)!
            return SearchViewModel(serviceManager: serviceManager,
                                   searchDataAccessProvider: searchDataAccessProvider)
        }

        container.register(SearchViewController.self) { resolver in
            let viewModel = resolver.resolve(SearchViewModel.self)!
            let cloudTagViewModel = resolver.resolve(CloudTagViewModel.self)!
            let pastSearchesViewModel = resolver.resolve(PastSearchesViewModel.self)!
            return SearchViewController(viewModel: viewModel,
                                        cloudTagViewModel: cloudTagViewModel,
                                        pastSearchesViewModel: pastSearchesViewModel)
        }
    }
}
