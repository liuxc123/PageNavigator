//
//  NavigationMap.swift
//  PageNavigator_Example
//
//  Created by liuxc on 2019/10/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import PageNavigator

let globalWindow = UIWindow()
let navigator = TabNavigator(window: globalWindow, sceneURLHandler: URLSceneHandler())

enum NavigationMap {
    static func initialize(navigator: Navigator) {
        setupInterceptor(navigator: navigator)
        setupSceneHandler(navigator: navigator)
        setupURLHandler(navigator: navigator)
    }

    static func setupInterceptor(navigator: Navigator) {
        navigator.register(Interceptor())
    }

    static func setupSceneHandler(navigator: Navigator) {
        navigator.register([CollectionSceneHandler(),
                            TableSceneHandler(),
                            RedSceneHandler(),
                            GreenSceneHandler(),
                            BlueSceneHandler(),
                            NavBarSceneHandler(),
                            TabBarSceneHandler(),
                            WebViewSceneHandler()])
    }

    static func setupURLHandler(navigator: Navigator) {

        navigator.register("navigator://red") { (url, values, context) -> SceneContext? in
            return SceneContext(sceneName: .red, parameters: url.queryParameters, type: .select, isAnimated: true)
        }

        navigator.register("navigator://green") { (url, values, context) -> SceneContext? in
            return SceneContext(sceneName: .green, parameters: url.queryParameters, type: .select, isAnimated: true)
        }

        navigator.register("navigator://blue") { (url, values, context) -> SceneContext? in
            return SceneContext(sceneName: .blue, parameters: url.queryParameters, type: .select, isAnimated: true)
        }

        navigator.register("navigator://collection") { (url, values, context) -> SceneContext? in
            debugPrint("values: \(values)")
            return SceneContext(sceneName: .collection, parameters: url.queryParameters, type: .push, isAnimated: true)
        }

        navigator.register("http://<path:_>") { (url, values, context) -> SceneContext? in
            return SceneContext(sceneName: .webview, parameters: ["url": url], type: .modal, isAnimated: true)
        }

        navigator.register("https://<path:_>") { (url, values, context) -> SceneContext? in
            return SceneContext(sceneName: .webview, parameters: ["url": url], type: .modal, isAnimated: true)
        }

        navigator.handle("navigator://toast") { (url, values, context) -> Bool in
            print("handle: \(url.queryParameters["text"] ?? "")")
            return true
        }

        navigator.handle("navigator://<path:_>") { (url, values, context) -> Bool in
          // No navigator match, do analytics or fallback function here
          print("[Navigator] NavigationMap.\(#function):\(#line) - global fallback function is called")
          return true
        }
    }
}

extension SceneHandler {

    /// rewirte default NavigationContainer
    func navigation(with viewController: UIViewController) -> UINavigationController {
        let navigationController = GTUINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = viewController.modalPresentationStyle
        navigationController.transitioningDelegate = viewController.transitioningDelegate
        viewController.transitioningDelegate = nil
        return navigationController
    }
}
