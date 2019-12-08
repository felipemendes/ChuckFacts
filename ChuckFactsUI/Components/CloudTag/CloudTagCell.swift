//
//  CloudTagCell.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 08/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

class CloudTagCell: UICollectionViewCell {

    // MARK: - METRICS

    private struct Metrics {
        static let cornerRadius: CGFloat = 4
    }

    // MARK: - PROPERTIES

    private var value: String?

    // MARK: - UI

    private lazy var cloudTagView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .primary
        view.layer.cornerRadius = Metrics.cornerRadius
        return view
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.apply(typography: .subtitle(weight: .semibold), with: .white)
        return label
    }()

    // MARK: - INITIALIZERS

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LIFE CYCLE

    override func layoutSubviews() {
        super.layoutSubviews()
        constraintUI()
    }

    // MARK: - PUBLIC API

    public func setupCell(with value: String) {
        self.value = value
        setupUI()
    }

    // MARK: - SETUP

    private func setupUI() {
        valueLabel.text = value
    }

    private func constraintUI() {
        addSubview(cloudTagView)
        cloudTagView.addSubview(valueLabel)

        cloudTagView.constraintToSuperview()
        valueLabel.constraintToSuperview()
    }
}
