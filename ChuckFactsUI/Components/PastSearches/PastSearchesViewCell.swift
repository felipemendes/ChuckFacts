//
//  PastSearchesViewCell.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 08/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

class PastSearchesViewCell: UICollectionViewCell {

    // MARK: - PROPERTIES

    private var value: String?

    // MARK: - UI

    private lazy var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.apply(typography: .subtitle(weight: .regular), with: .black)
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
        addSubview(valueLabel)
        valueLabel.constraintToSuperview()
    }
}
