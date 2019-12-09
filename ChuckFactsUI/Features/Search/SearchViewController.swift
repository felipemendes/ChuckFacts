//
//  SearchViewController.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit
import RxSwift

public class SearchViewController: UIViewController {

    // MARK: - METRICS

    private struct Metrics {
        static let cloudTagViewLeading: CGFloat = 8
        static let cloudTagViewTrailing: CGFloat = -8
        static let cloudTagViewTop: CGFloat = 8
        static let cloudTagViewHeight: CGFloat = 140

        static let pastSearchesViewLeading: CGFloat = 8
        static let pastSearchesViewTrailing: CGFloat = -8
        static let pastSearchesViewTop: CGFloat = 8
        static let pastSearchesViewBottom: CGFloat = -8
    }

    // MARK: - PUBLIC API

    weak var delegate: SearchViewControllerDelegate?

    // MARK: - PROPERTIES

    private let viewModel: SearchViewModel
    private let cloudTagViewModel: CloudTagViewModel
    private let pastSearchesViewModel: PastSearchesViewModel

    // MARK: - INITIALIZERS

    public init(viewModel: SearchViewModel,
                cloudTagViewModel: CloudTagViewModel,
                pastSearchesViewModel: PastSearchesViewModel) {
        self.viewModel = viewModel
        self.cloudTagViewModel = cloudTagViewModel
        self.pastSearchesViewModel = pastSearchesViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var cloudTagView: CloudTagView = {
        let cloudTagView = CloudTagView(viewModel: cloudTagViewModel)
        cloudTagView.translatesAutoresizingMaskIntoConstraints = false
        cloudTagView.delegate = self
        return cloudTagView
    }()

    private lazy var pastSearchesView: PastSearchesView = {
        let pastSearchesView = PastSearchesView(viewModel: pastSearchesViewModel)
        pastSearchesView.translatesAutoresizingMaskIntoConstraints = false
        pastSearchesView.delegate = self
        return pastSearchesView
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
        view.addSubview(pastSearchesView)

        NSLayoutConstraint.activate([
            cloudTagView.topAnchor.constraint(equalTo: view.topAnchor,
                                              constant: Metrics.cloudTagViewTop),
            cloudTagView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Metrics.cloudTagViewLeading),
            cloudTagView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: Metrics.cloudTagViewTrailing),
            cloudTagView.heightAnchor.constraint(equalToConstant: Metrics.cloudTagViewHeight),

            pastSearchesView.topAnchor.constraint(equalTo: cloudTagView.bottomAnchor,
                                              constant: Metrics.pastSearchesViewTop),
            pastSearchesView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Metrics.pastSearchesViewLeading),
            pastSearchesView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: Metrics.pastSearchesViewTrailing),
            pastSearchesView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                     constant: Metrics.pastSearchesViewBottom)
        ])
    }
}

// MARK: - CloudTagViewDelegate

extension SearchViewController: CloudTagViewDelegate {
    func cloudTagView(_ cloudTagView: CloudTagView, didTappedIn keyword: String) {
        delegate?.searchViewControllerDelegate(self, didTapSearch: keyword)
    }
}

// MARK: - PastSearchesViewDelegate

extension SearchViewController: PastSearchesViewDelegate {
    func pastSearchesView(_ pastSearchesView: PastSearchesView, didTappedIn keyword: String) {
        delegate?.searchViewControllerDelegate(self, didTapSearch: keyword)
    }
}
