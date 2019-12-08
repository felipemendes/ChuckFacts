//
//  String+Extension.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 08/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func estimateSize(for size: CGFloat) -> CGSize {
        let font = UIFont.systemFont(ofSize: size, weight: .regular)
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}
