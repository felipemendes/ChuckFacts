//
//  Guideline.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

public struct Guideline {

    /// Typograph constraints
    ///
    /// - title: Size of 20 points
    /// - body: Size of 14 points
    public enum Typography {
        case title(weight: UIFont.CustomWeight)
        case body(weight: UIFont.CustomWeight)

        public var font: UIFont {
            switch self {
            case .title(let weight): return .customFont(ofSize: 20, weight: weight)
            case .body(let weight): return .customFont(ofSize: 16, weight: weight)
            }
        }
    }
}
