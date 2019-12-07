//
//  PlaceholderView.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 06/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

enum PlaceholderType {
    case home
    case search

    var image: UIImage {
        switch self {
        case .home:
            return .shareIcon
        case .search:
            return .shareIcon
        }
    }
}

final class PlaceholderView: UIView {

    // MARK: - PRIVATE PROPERTIES

    private let placeholderType: PlaceholderType

    // MARK: - INITIALIZERS

    init(placeholderType: PlaceholderType) {
        self.placeholderType = placeholderType
        super.init(frame: .zero)
        constraintUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = placeholderType.image
        return imageView
    }()

    // MARK: - SETUP

    private func constraintUI() {
        addSubview(containerView)
        containerView.constraintToSuperview()
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
