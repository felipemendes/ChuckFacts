//
//  AppDelegate.swift
//  Chuck-Norris-Facts
//
//  Created by Felipe Mendes on 23/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit
import Swinject

// swiftlint:disable force_cast
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainFlowController: FlowController?
    let assembler = Assembler(DepedencyInjection.build())

    static let container = Container()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        handleFirstPresentation()

        return true
    }

    // MARK: - SETUP

    private func handleFirstPresentation() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()

        presentHome(from: window?.rootViewController as! UINavigationController)

        window?.makeKeyAndVisible()
    }
}

// MARK: - FlowControllers

extension AppDelegate {

    // MARK: HOME

    func presentHome(from navigationController: UINavigationController) {
        mainFlowController = assembler.resolver.resolve(FlowController.self, argument: navigationController)
        mainFlowController?.start()
    }
}
