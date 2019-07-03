//
//  SceneHandler.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

public protocol SceneHandler: class {
    var name: SceneName { get }
    var isReloadable: Bool { get }

    func view(with parameters: Parameters) -> UIViewController
    func navigation(with viewController: UIViewController) -> UINavigationController
    func reload(_ viewController: UIViewController, parameters: Parameters)
}

// MARK: Default implementation

public extension SceneHandler {
    var isReloadable: Bool {
        return true
    }

    func navigation(with viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = viewController.modalPresentationStyle
        navigationController.transitioningDelegate = viewController.transitioningDelegate
        viewController.transitioningDelegate = nil
        return navigationController
    }

    func reload(_ viewController: UIViewController, parameters: Parameters) {
        // Do nothing by default
    }
}
