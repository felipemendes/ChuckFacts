//
//  UIImage+Extension.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 06/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

private class ChuckImage { }

extension UIImage {
    public class var shareIcon: UIImage {
        return UIImage(named: "share", in: Bundle(for: ChuckImage.self), compatibleWith: nil)!
    }
}
