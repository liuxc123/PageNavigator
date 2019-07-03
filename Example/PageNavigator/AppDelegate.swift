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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        setupWindow()
        setupNavigator()

        return true
    }

}

extension AppDelegate {
    func setupWindow() {
        window = globalWindow
        window?.makeKeyAndVisible()
    }

    func setupNavigator() {
        navigator.register(Interceptor())
        navigator.register([CollectionSceneHandler(),
                            TableSceneHandler(),
                            RedSceneHandler(),
                            GreenSceneHandler(),
                            BlueSceneHandler(),
                            NavBarSceneHandler(),
                            TabBarSceneHandler(),
                            WebViewSceneHandler()])
        navigator.root(.tabBar)
        navigator.setTabs([.blue, .red, .table])
    }
}

private extension SceneContext {
    static let blue = SceneContext(sceneName: .blue)
    static let red = SceneContext(sceneName: .red)
    static let green = SceneContext(sceneName: .green)
    static let table = SceneContext(sceneName: .table)
    static let collection = SceneContext(sceneName: .collection)
}
