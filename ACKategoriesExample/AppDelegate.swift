//
//  AppDelegate.swift
//  ACKategories-Example
//
//  Created by Jakub Olejník on 06/02/2018.
//  Copyright © 2018 Josef Dolezal. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    private lazy var appFlow = AppFlowCoordinator()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.window?.makeKeyAndVisible()
        appFlow.start(in: window)
        return true
    }
}
