//
//  AppDelegate.swift
//  Chuck-Norris-Facts
//
//  Created by Felipe Mendes on 23/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let mainFlowController = MainFlowController()

    static let container = Container()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Container.loggingFunction = nil
        AppDelegate.container.registerDependencies()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainFlowController
        window?.makeKeyAndVisible()

        mainFlowController.start()

        return true
    }
}
