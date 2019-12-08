//
//  SearchViewController.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 03/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

public class SearchViewController: UIViewController {

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

    // MARK: - LIFE CYCLE

    override public func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }

    // MARK: - PRIVATE SETUP

    private func layoutView() {
        view.backgroundColor = .white
    }
}
