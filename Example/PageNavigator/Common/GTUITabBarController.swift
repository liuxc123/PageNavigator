//
//  GTUITabBarController.swift
//  PageNavigator_Example
//
//  Created by liuxc on 2019/7/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import PageNavigator

class GTUITabBarController: UITabBarController {

    
}

// MARK: ViewControllerContainer

extension GTUITabBarController: ViewControllerContainer {
    public var rootViewController: UIViewController {
        return self
    }

    public var firstLevelNavigationControllers: [UINavigationController] {
        let viewControllers = self.viewControllers ?? []
        return viewControllers.compactMap { $0 as? UINavigationController }
    }

    public var visibleNavigationController: UINavigationController {
        return selectedViewController as! UINavigationController
    }

    public func select(viewController: UIViewController) {
        selectedViewController = viewController
    }
}
