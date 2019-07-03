//
//  TabBarContainer.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

open class TabBarContainer: UITabBarController {

}

// MARK: ViewControllerContainer

extension TabBarContainer: ViewControllerContainer {
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
