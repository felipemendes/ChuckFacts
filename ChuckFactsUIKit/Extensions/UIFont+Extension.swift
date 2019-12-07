//
//  UIFont+Extension.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

extension UIFont {

    public enum CustomWeight: CaseIterable {
        case regular
        case semibold

        var asUIFontWeight: UIFont.Weight {
            switch self {
            case .regular: return .regular
            case .semibold: return .semibold
            }
        }
    }

    public class func customFont(ofSize fontSize: CGFloat, weight: UIFont.CustomWeight) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: weight.asUIFontWeight)
    }
}
