//
//  CloudTagView.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 08/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

protocol CloudTagViewDelegate: AnyObject {
    func cloudTagView(_ cloudTagView: CloudTagView, didTappedIn keywork: String)
}

final class CloudTagView: UIControl {

    // MARK: - CONSTANTS

    private struct Constants {
        static let cloudTagReuseIdentifier: String = "CloudTagCell"
        static let fontSize: CGFloat = 12
        static let spacingWidth: CGFloat = 16
        static let spacingHeight: CGFloat = 8
    }

    // MARK: - PRIVATE PROPERTIES

    private let items: [String]

    // MARK: - PUBLIC API

    public weak var delegate: CloudTagViewDelegate?

    // MARK: - INITIALIZER

    public init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        setupView()
        constraintUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        return UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
    }()

    // MARK: - SETUP

    private func setupView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CloudTagCell.self, forCellWithReuseIdentifier: Constants.cloudTagReuseIdentifier)
    }

    private func constraintUI() {
        addSubview(collectionView)
        collectionView.constraintToSuperview()
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
        let width = item.estimateSize(for: Constants.fontSize).width + Constants.spacingWidth
        let height = item.estimateSize(for: 14).height + Constants.spacingHeight

        return CGSize(width: width, height: height)
    }
}
