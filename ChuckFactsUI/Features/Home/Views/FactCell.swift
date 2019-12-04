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
        static let margin: CGFloat = 16
        static let cornerRadius: CGFloat = 8
        static let shadowOpacity: Float = 1
        static let shadowRadius: CGFloat = 4
    }

    // MARK: - UI

    private lazy var containerView: UIView = {
        let stackView = UIView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .red
        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.apply(typography: .body(weight: .regular), with: .black)
        return label
    }()

    private lazy var shadowBoxView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        boxSetup()
    }

    // MARK: - PUBLIC API

    public func setup(with title: String) {
        titleLabel.text = title
    }

    // MARK: - SETUP

    private func setupCell() {
        selectionStyle = .none
        contentView.backgroundColor = .white
    }

    private func boxSetup() {
        shadowBoxView.layer.cornerRadius = Metrics.cornerRadius
        shadowBoxView.clipsToBounds = true

        shadowBoxView.layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                                      cornerRadius: Metrics.cornerRadius).cgPath
        shadowBoxView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        shadowBoxView.layer.shadowOpacity = Metrics.shadowOpacity
        shadowBoxView.layer.shadowRadius = Metrics.shadowRadius
        shadowBoxView.layer.shadowOffset = .init(width: 0, height: 1)

        layer.masksToBounds = false
    }

    private func constraintUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Metrics.margin),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.margin),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Metrics.margin)
        ])
    }
}
