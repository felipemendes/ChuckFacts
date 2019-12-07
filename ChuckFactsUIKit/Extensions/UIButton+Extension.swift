//
//  UIButton+Extension.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

extension UIButton {
    public func apply(typography: Guideline.Typography, with color: UIColor) {
        titleLabel?.font = typography.font
        setTitleColor(color, for: .normal)
    }
}
