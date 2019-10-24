//
//  AppDelegate.swift
//  PageNavigator
//
//  Created by liuxc123 on 07/03/2019.
//  Copyright (c) 2019 liuxc123. All rights reserved.
//

import UIKit
import PageNavigator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        NavigationMap.initialize(navigator: navigator)
        setupRoot()
        setupWindow()

        return true
    }

    /// 处理url open
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return navigator.url(url)
    }

}

extension AppDelegate {
    func setupWindow() {
        window = globalWindow
        window?.makeKeyAndVisible()
    }

    func setupRoot() {
        NavigatorLogger.level = .debug
        navigator.root(.tabBar)
        navigator.setTabs([.red, .green, .blue, .table])
    }
}

private extension SceneContext {
    static let blue = SceneContext(sceneName: .blue)
    static let red = SceneContext(sceneName: .red)
    static let green = SceneContext(sceneName: .green)
    static let table = SceneContext(sceneName: .table)
    static let collection = SceneContext(sceneName: .collection)
}
