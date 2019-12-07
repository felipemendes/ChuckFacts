//
//  HomeViewControllerDelegate.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 06/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

public protocol HomeViewControllerDelegate: AnyObject {
    func homeViewControllerDelegate(_ viewController: UIViewController, didTapShare message: String)
}
