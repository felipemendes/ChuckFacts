//
//  AppDelegate.swift
//  ChuckFacts
//
//  Created by Felipe Mendes on 23/11/19.
//  Copyright © 2019 Felipe Mendes. All rights reserved.
//

import UIKit
import Swinject
import CoreData

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

    func applicationDidBecomeActive(_ application: UIApplication) {
        SettingsBundleHelper.performSettings()
    }

    // MARK: - SETUP

    private func handleFirstPresentation() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()

        presentHome(from: window?.rootViewController as! UINavigationController)

        window?.makeKeyAndVisible()
    }

    // MARK: - Core Data

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

// MARK: - FlowControllers

extension AppDelegate {

    // MARK: HOME

    func presentHome(from navigationController: UINavigationController) {
        mainFlowController = assembler.resolver.resolve(FlowController.self, argument: navigationController)
        mainFlowController?.start()
    }
}

// MARK: - Core Data Saving Support

extension AppDelegate {

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
