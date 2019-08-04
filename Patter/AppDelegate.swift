//
//  AppDelegate.swift
//  Patter
//
//  Created by Maksim Ivanov on 07/03/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppSetter().setup()

        let navigationController = UINavigationController(rootViewController: rootViewController())

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

    private func rootViewController() -> UIViewController {
        return Container.sharedContainer.resolve(PatterListBuilder.self)!.buildPatterListModule()!
    }

}
