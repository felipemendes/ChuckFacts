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
    func updateView(to state: ViewState)
}

// MARK: - EXTENSIONS

extension ViewLayoutable where Self: UIViewController {

    // MARK: - DEFAULT IMPLEMENTATIONS

    func updateView(to state: ViewState) {
        switch state {
        case .loading:
            placeholderView.isHidden = false
            view.isHidden = true
        case .content:
            placeholderView.isHidden = true
            view.isHidden = false
        }
    }

    // MARK: PRIVATE

    private func constraintContainerLayout() {
        view.addSubview(placeholderView)

        NSLayoutConstraint.activate([
            placeholderView.topAnchor.constraint(equalTo: view.topAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
