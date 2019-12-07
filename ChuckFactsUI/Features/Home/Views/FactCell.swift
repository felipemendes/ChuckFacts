//
//  FactCell.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

class FactCell: UITableViewCell {

    // MARK: - CONSTANTS AND METRICS

    private struct Constants {
        static let defaultShareMessage: String = "Check out Chuck Norris facts through this app"
    }

    private struct Metrics {
        static let cornerRadius: CGFloat = 8
        static let shadowOpacity: Float = 1
        static let shadowRadius: CGFloat = 5

        static let containerTop: CGFloat = 16
        static let containerLeading: CGFloat = 16
        static let containerTrailing: CGFloat = -16
        static let containerBottom: CGFloat = -16

        static let valueTop: CGFloat = 12
        static let valueLeading: CGFloat = 12
        static let valueTrailing: CGFloat = -12

        static let categoryTop: CGFloat = 12
        static let categoryBottom: CGFloat = -12

        static let shareSize: CGFloat = 20
        static let shareTrailing: CGFloat = -12
        static let shareBottom: CGFloat = -12
    }

    // MARK: - PROPERTIES

    private var fact: Fact?
    public weak var delegate: FactCellDelegate?

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

    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(.shareIcon, for: .normal)
        button.addTarget(self, action: #selector(didTapShare(_:)), for: .touchUpInside)
        return button
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
        cardSetup()
    }

    // MARK: - PUBLIC API

    public func setup(with fact: Fact?) {
        self.fact = fact
        setupCell()
    }

    // MARK: - SETUP

    private func setupCell() {
        guard let fact = fact else { return }
        valueLabel.text = fact.value
        categoryLabel.text = fact.categories.first ?? "UNCATEGORIZED"
    }

    private func cardSetup() {
        cardView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        cardView.layer.shadowOpacity = Metrics.shadowOpacity
        cardView.layer.shadowOffset = CGSize.zero
        cardView.layer.shadowRadius = Metrics.shadowRadius
        cardView.layer.cornerRadius = Metrics.cornerRadius
    }

    private func constraintUI() {
        addSubview(containerView)
        containerView.addSubview(cardView)
        cardView.addSubview(valueLabel)
        cardView.addSubview(categoryLabel)
        cardView.addSubview(shareButton)

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

            valueLabel.topAnchor.constraint(equalTo: cardView.topAnchor,
                                               constant: Metrics.valueTop),
            valueLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,
                                                   constant: Metrics.valueLeading),
            valueLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,
                                                    constant: Metrics.valueTrailing),

            categoryLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor,
                                               constant: Metrics.categoryTop),
            categoryLabel.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor,
                                                  constant: Metrics.containerBottom),

            shareButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,
                                                  constant: Metrics.shareTrailing),
            shareButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor,
                                                constant: Metrics.shareBottom),
            shareButton.heightAnchor.constraint(equalToConstant: Metrics.shareSize),
            shareButton.widthAnchor.constraint(equalToConstant: Metrics.shareSize)
        ])
    }

    // MARK: - SELECTORS

    @objc private func didTapShare(_ sender: Any) {
        delegate?.didTapShare(message: fact?.value ?? Constants.defaultShareMessage)
    }
}
