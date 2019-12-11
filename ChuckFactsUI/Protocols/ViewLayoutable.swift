//
//  ViewLayoutable.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 06/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit
import JGProgressHUD

protocol ViewLayoutable: class {
    var placeholderView: PlaceholderView { get }
    var alertView: JGProgressHUD { get }

    func constraintLayout()
    func updateView(to state: ViewState, above mainView: UIView)
    func updateAlert(to type: AlertType)
}

// MARK: - EXTENSIONS

extension ViewLayoutable where Self: UIViewController {

    // MARK: - DEFAULT IMPLEMENTATIONS

    func updateView(to state: ViewState, above mainView: UIView) {
        switch state {
        case .empty:
            placeholderView.isHidden = false
            mainView.isHidden = true
        case .content:
            placeholderView.isHidden = true
            mainView.isHidden = false
        }
    }

    func updateAlert(to type: AlertType) {
        alertView.show(in: view, animated: true)

        switch type {
        case .loading:
            alertView.textLabel.text = "Don't let Chuck Norris wait"
        case .error(let message):
            alertView.textLabel.text = "Error: \(message)"
        case .dismiss:
            alertView.dismiss(animated: true)
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
