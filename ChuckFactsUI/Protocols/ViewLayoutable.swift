//
//  ViewLayoutable.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 06/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

protocol ViewLayoutable: class {
    var placeholderView: PlaceholderView { get }
    func constraintLayout()
    func updateView(to state: ViewState, above mainView: UIView)
}

// MARK: - EXTENSIONS

extension ViewLayoutable where Self: UIViewController {

    // MARK: - DEFAULT IMPLEMENTATIONS

    func updateView(to state: ViewState, above mainView: UIView) {
        switch state {
        case .loading:
            placeholderView.isHidden = false
            mainView.isHidden = true
        case .content:
            placeholderView.isHidden = true
            mainView.isHidden = false
        }
    }

    func constraintLayout() {
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(placeholderView)

        NSLayoutConstraint.activate([
            placeholderView.topAnchor.constraint(equalTo: view.topAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
