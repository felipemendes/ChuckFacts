//
//  UILabel+Extension.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

extension UILabel {
    public func apply(typography: Guideline.Typography, with color: UIColor) {
        font = typography.font
        textColor = color
    }
}
