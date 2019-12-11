//
//  UIView+Extension.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 05/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

extension UIView {
    public func constraintToSuperview(top: CGFloat = 0,
                                      leading: CGFloat = 0,
                                      trailing: CGFloat = 0,
                                      bottom: CGFloat = 0,
                                      bottomPriority: UILayoutPriority = .required) {

        guard let superview = self.superview else { return }
        let bottomConstraint = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom)

        let constraints = [
            safeTopAnchor.constraint(equalTo: superview.safeTopAnchor, constant: top),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: trailing),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: leading),
            bottomConstraint
        ]

        bottomConstraint.priority = bottomPriority
        NSLayoutConstraint.activate(constraints)
    }

    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
}
