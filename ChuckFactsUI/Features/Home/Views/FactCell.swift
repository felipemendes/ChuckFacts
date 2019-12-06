//
//  FactCell.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

class FactCell: UITableViewCell {

    // MARK: - CONSTANTS

    private struct Metrics {
        static let cornerRadius: CGFloat = 8
        static let shadowOpacity: Float = 1
        static let shadowRadius: CGFloat = 4

        static let containerTop: CGFloat = 16
        static let containerLeading: CGFloat = 16
        static let containerTrailing: CGFloat = -16
        static let containerBottom: CGFloat = -16

        static let categoryTop: CGFloat = 12
        static let categoryLeading: CGFloat = 12
        static let categoryTrailing: CGFloat = -12

        static let valueTop: CGFloat = 12
        static let valueBottom: CGFloat = -12
    }

    // MARK: - UI

    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var cardView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundGray
        return view
    }()

    private lazy var categoryLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.apply(typography: .body(weight: .semibold), with: .primary)
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.apply(typography: .title(weight: .regular), with: .black)
        label.numberOfLines = 0
        return label
    }()

    // MARK: - INITIALIZERS

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        constraintUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LIFE CYCLE

    override func layoutSubviews() {
        super.layoutSubviews()
        setupCell()
        cardSetup()
    }

    // MARK: - PUBLIC API

    public func setup(with fact: Fact?) {
        guard let fact = fact else { return }
        valueLabel.text = fact.value
        categoryLabel.text = fact.categories.first ?? "UNCATEGORIZED"
    }

    // MARK: - SETUP

    private func setupCell() {
        selectionStyle = .none
    }

    private func cardSetup() {
        cardView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowRadius = 5
        cardView.layer.cornerRadius = Metrics.cornerRadius
    }

    private func constraintUI() {
        addSubview(containerView)
        containerView.addSubview(cardView)
        cardView.addSubview(categoryLabel)
        cardView.addSubview(valueLabel)

        containerView.constraintToSuperview()

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: containerView.topAnchor,
                                          constant: Metrics.containerTop),
            cardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                              constant: Metrics.containerLeading),
            cardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                               constant: Metrics.containerTrailing),
            cardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                             constant: Metrics.containerBottom),

            categoryLabel.topAnchor.constraint(equalTo: cardView.topAnchor,
                                               constant: Metrics.categoryTop),
            categoryLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,
                                                   constant: Metrics.categoryLeading),
            categoryLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,
                                                    constant: Metrics.categoryTrailing),

            valueLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: Metrics.valueTop),
            valueLabel.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: categoryLabel.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: Metrics.valueBottom)
            ])
    }
}
