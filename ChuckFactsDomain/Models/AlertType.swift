//
//  AlertType.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 10/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

enum AlertType {
    case loading
    case error(message: String)
    case dismiss
}
