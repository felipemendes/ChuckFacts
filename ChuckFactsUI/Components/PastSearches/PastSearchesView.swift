//
//  PastSearchesView.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 08/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit
import RxSwift

protocol PastSearchesViewDelegate: AnyObject {
    func pastSearchesView(_ pastSearchesView: PastSearchesView, didTappedIn keyword: String)
}

final class PastSearchesView: UIControl {

    // MARK: - CONSTANTS AND METRICS

    private struct Constants {
        static let pastSearchesReuseIdentifier: String = "PastSearchesCell"
        static let fontSize: CGFloat = 16
        static let title: String = "Past Searches"
        static let amountPastSearchesToShow: Int = 10
        static let rowHeight: CGFloat = 20
    }

    private struct Metrics {
        static let titleTop: CGFloat = 16
        static let collectionTop: CGFloat = 16
    }

    // MARK: - PRIVATE PROPERTIES

    private var disposeBag = DisposeBag()
    private var items = [Search]()
    private let viewModel: PastSearchesViewModel

    // MARK: - PUBLIC API

    public weak var delegate: PastSearchesViewDelegate?

    // MARK: - INITIALIZER

    public init(viewModel: PastSearchesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        constraintUI()
        reloadView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = Constants.title
        label.apply(typography: .title(weight: .semibold), with: .black)
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        return UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
    }()

    // MARK: - SETUP

    private func reloadView() {
        items = viewModel.retrieveSearches().value

    }

    private func setupView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PastSearchesViewCell.self,
                                forCellWithReuseIdentifier: Constants.pastSearchesReuseIdentifier)
    }

    private func constraintUI() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(collectionView)

        containerView.constraintToSuperview()

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor,
                                            constant: Metrics.titleTop),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                constant: Metrics.collectionTop),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UICollectionView

extension PastSearchesView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.pastSearchesReuseIdentifier,
                                                            for: indexPath) as? PastSearchesViewCell else {
                                                                return UICollectionViewCell()
        }

        cell.setupCell(with: items[indexPath.row].keyword)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = frame.width
        let height = Constants.rowHeight
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pastSearchesView(self, didTappedIn: items[indexPath.row].keyword)
    }
}
