//
//  HomeViewController.swift
//  Chuck-Norris-Facts
//
//  Created by Felipe Mendes on 24/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutView()
    }

    // MARK: - PRIVATE SETUP

    private func layoutView() {
        view.backgroundColor = .white
    }
}
