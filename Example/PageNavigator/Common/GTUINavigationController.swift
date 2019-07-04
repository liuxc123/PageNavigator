//
//  GTUINavigationController.swift
//  PageNavigator_Example
//
//  Created by liuxc on 2019/7/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import PageNavigator

class GTUINavigationController: UINavigationController {

}

// MARK: ViewControllerContainer

extension GTUINavigationController: ViewControllerContainer {
    public var rootViewController: UIViewController {
        return self
    }

    public var firstLevelNavigationControllers: [UINavigationController] {
        return [self]
    }

    public var visibleNavigationController: UINavigationController {
        return self
    }

    public func select(viewController: UIViewController) {
        popToRootViewController(animated: true)
    }
}
