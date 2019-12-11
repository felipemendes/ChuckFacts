//
//  SettingsBundleHelper.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 09/12/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import Foundation

class SettingsBundleHelper {

    class func performSettings() {

        let searchDataAccessProvider = SearchDataAccessProvider()
        let resetKey = "clear_cache"

        if UserDefaults.standard.bool(forKey: resetKey) {
            UserDefaults.standard.set(false, forKey: resetKey)
            let appDomain: String? = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            searchDataAccessProvider.deleteAll()
        }
    }
}
