//
//  DepedencyInjection.swift
//  Chuck-Norris-Facts
//
//  Created by Felipe Mendes on 25/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Swinject

public class DepedencyInjection {

    /// Registers and builds the dependency graph
    ///
    /// - Returns: Returns an array of assembly already registered
    public static func build() -> [Assembly] {
        return [
            ChuckAssembly()
        ]
    }
}
