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

    var image: UIImage {
        switch self {
        case .home:
            return .chuckNorrisNoErrors
        }
    }
}

final class PlaceholderView: UIView {

    // MARK: - METRICS

    private struct Metrics {
        static let imageHeight: CGFloat = 200
    }

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
        view.backgroundColor = .white
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = placeholderType.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - SETUP

    private func constraintUI() {
        addSubview(containerView)
        containerView.constraintToSuperview()
        containerView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Metrics.imageHeight)
        ])
    }
}
