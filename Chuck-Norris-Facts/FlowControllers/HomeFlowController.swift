//
//  HomeFlowController.swift
//  Chuck-Norris-Facts
//
//  Created by Felipe Mendes on 24/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

final class HomeFlowController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func start() {
        let controller = HomeViewController()
        navigationBar.isHidden = true
        pushViewController(controller, animated: true)
    }
}
