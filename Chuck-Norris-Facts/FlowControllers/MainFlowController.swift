//
//  MainFlowController.swift
//  Chuck-Norris-Facts
//
//  Created by Felipe Mendes on 24/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

final class MainFlowController: UIViewController {

    func start() {
        let controller = HomeFlowController()
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
        controller.start()
    }
}
