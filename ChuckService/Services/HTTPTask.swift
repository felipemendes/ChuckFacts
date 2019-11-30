//
//  HTTPTask.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 28/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    case requestParameters(parameters: [String: Any])
}
