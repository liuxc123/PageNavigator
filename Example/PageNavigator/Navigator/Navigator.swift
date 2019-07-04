//
//  Navigator.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import PageNavigator

let globalWindow = UIWindow()
let navigator = TabNavigator(window: globalWindow, sceneURLHandler: URLSceneHandler())

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
