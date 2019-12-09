//
//  CloudTagView.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 08/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit
import RxSwift

protocol CloudTagViewDelegate: AnyObject {
    func cloudTagView(_ cloudTagView: CloudTagView, didTappedIn keyword: String)
}

final class CloudTagView: UIControl {

    // MARK: - CONSTANTS AND METRICS

    private struct Constants {
        static let cloudTagReuseIdentifier: String = "CloudTagCell"
        static let fontSize: CGFloat = 16
        static let title: String = "Suggestions"
        static let amountTagsToShow: Int = 8
    }

    private struct Metrics {
        static let spacingWidth: CGFloat = 16
        static let spacingHeight: CGFloat = 8

        static let titleTop: CGFloat = 16
        static let collectionTop: CGFloat = 16
    }

    // MARK: - PRIVATE PROPERTIES

    private var disposeBag = DisposeBag()
    private var items = [String]()
    private let viewModel: CloudTagViewModel

    // MARK: - PUBLIC API

    public weak var delegate: CloudTagViewDelegate?

    // MARK: - INITIALIZER

    public init(viewModel: CloudTagViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
        constraintUI()
        bindObservables()
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

    // MARK: - BINDING

    private func bindObservables() {
        viewModel.categoryObservable.observeOn(MainScheduler.instance)
            .subscribe(onNext: { categoryResponse in
                self.items = categoryResponse
                self.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }

    // MARK: - SETUP

    private func reloadView() {
        viewModel.retrieveCategories(by: Constants.amountTagsToShow, shuffled: true)
        bindObservables()
    }

    private func setupView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CloudTagCell.self, forCellWithReuseIdentifier: Constants.cloudTagReuseIdentifier)
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

extension CloudTagView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cloudTagReuseIdentifier,
                                                            for: indexPath) as? CloudTagCell else {
            return UICollectionViewCell()
        }

        cell.setupCell(with: items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let item = items[indexPath.row]
        let width = item.estimateSize(for: Constants.fontSize).width + Metrics.spacingWidth
        let height = item.estimateSize(for: 14).height + Metrics.spacingHeight

        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cloudTagView(self, didTappedIn: items[indexPath.row])
    }
}
