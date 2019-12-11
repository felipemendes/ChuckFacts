//
//  SearchViewControllerDelegate.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 07/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit

public protocol SearchViewControllerDelegate: AnyObject {
    func searchViewControllerDelegate(_ viewController: UIViewController, didTapSearch keyword: String)
}
