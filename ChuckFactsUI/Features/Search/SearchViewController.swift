//
//  SearchViewController.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

public class SearchViewController: UIViewController {

    // MARK: - METRICS

    private struct Metrics {
        static let cloudTagViewLeading: CGFloat = 8
        static let cloudTagViewTrailing: CGFloat = -8
        static let cloudTagViewTop: CGFloat = 8
        static let cloudTagViewHeight: CGFloat = 200
    }

    // MARK: - PUBLIC API

    weak var delegate: SearchViewControllerDelegate?

    // MARK: - PROPERTIES

    private let viewModel: SearchViewModel

    // MARK: - INITIALIZERS

    public init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var cloudTagView: CloudTagView = {
        let cloudTagView = CloudTagView(items: ["Dev", "Animal"])
        cloudTagView.translatesAutoresizingMaskIntoConstraints = false
        return cloudTagView
    }()

    // MARK: - LIFE CYCLE

    override public func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }

    // MARK: - PRIVATE SETUP

    private func layoutView() {
        view.backgroundColor = .white
        view.addSubview(cloudTagView)

        NSLayoutConstraint.activate([
            cloudTagView.topAnchor.constraint(equalTo: view.topAnchor,
                                              constant: Metrics.cloudTagViewTop),
            cloudTagView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Metrics.cloudTagViewLeading),
            cloudTagView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: Metrics.cloudTagViewTrailing),
            cloudTagView.heightAnchor.constraint(equalToConstant: Metrics.cloudTagViewHeight)
        ])
    }
}
