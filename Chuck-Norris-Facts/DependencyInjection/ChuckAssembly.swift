//
//  ChuckAssembly.swift
//  Chuck-Norris-Facts
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

        // MARK: - HomeViewController

        container.register(HomeViewController.self) { _ in
            return HomeViewController()
        }
    }
}
