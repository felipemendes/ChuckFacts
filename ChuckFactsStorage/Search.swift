//
//  Search.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 02/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation
import CoreData

@objc(Search)
public class Search: NSManagedObject {

    @nonobjc public class func searchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var keyword: String
}
