//
//  Array+Extension.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 08/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

public extension Array {
    func shuffled(by amount: Int?) -> [Element] {
        guard let amount = amount else {
            return Array(shuffled())
        }
        return Array(shuffled().prefix(amount))
    }
}
