//
//  UIColor+Extension.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 05/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    @objc class var primary: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "primary") ?? .lightGray
        } else {
            return .rgb(red: 10, green: 132, blue: 255)
        }
    }

    @objc class var backgroundGray: UIColor {
        if #available(iOS 11.0, *) {
            return UIColor(named: "backgroundGray") ?? .lightGray
        } else {
            return .rgb(red: 90, green: 200, blue: 250)
        }
    }
}
