//
//  RandomFactInterfaceController.swift
//  ChuckFacts WatchKit App Extension
//
//  Created by Felipe Mendes on 17/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import WatchKit
import Foundation

class RandomFactInterfaceController: WKInterfaceController {

    // MARK: - CONSTANTS

    private struct Constants {
        static let defaultCategoryName: String = "UNCATEGORIZED"
    }

    // MARK: - PRIVATE PROPERTIES

    private let serviceManager = ServiceManager()
    @IBOutlet weak var tableViewFacts: WKInterfaceTable!

    // MARK: - LIFE CYCLE

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        reloadData()
    }

    // MARK: - PRIVATE FUNCTIONS

    private func reloadData() {
        serviceManager.getRandom { fact, _ in
            self.tableViewFacts.setNumberOfRows(1, withRowType: "FactRowController")
            guard let fact = fact, let row = self.tableViewFacts.rowController(at: 0)
                as? FactRowController else {
                return
            }
            
            row.category.setText(self.retrieveCategoryName(for: fact))
            row.fact.setText(fact.value)
        }
    }

    private func retrieveCategoryName(for fact: Fact) -> String {
        guard let name = fact.categories.first else {
            return Constants.defaultCategoryName
        }
        return name?.uppercased() ?? Constants.defaultCategoryName
    }
}
