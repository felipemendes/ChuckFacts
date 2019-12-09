//
//  ComponentAssembly.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 08/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Swinject

public class ComponentAssembly: Assembly {

    public func assemble(container: Container) {

        // MARK: - CloudTagView

        container.register(CloudTagViewModel.self) { resolver in
            let serviceManager = resolver.resolve(ServiceManager.self)!
            return CloudTagViewModel(serviceManager: serviceManager)
        }

        // MARK: - PastSearchesView

        container.register(PastSearchesViewModel.self) { resolver in
            let searchDataAccessProvider = resolver.resolve(SearchDataAccessProvider.self)!
            return PastSearchesViewModel(searchDataAccessProvider: searchDataAccessProvider)
        }
    }
}
