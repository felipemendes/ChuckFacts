//
//  ServiceAssembly.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 04/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Swinject

public class ServiceAssembly: Assembly {

    public func assemble(container: Container) {

        // MARK: - ServiceManager

        container.register(ServiceManager.self) { _ in
            return ServiceManager()
        }
    }
}
