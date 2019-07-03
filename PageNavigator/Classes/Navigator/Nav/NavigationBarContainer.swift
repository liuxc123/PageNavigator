//
//  NavigationBarContainer.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

open class NavigationBarContainer: UINavigationController {

}

// MARK: ViewControllerContainer

extension NavigationBarContainer: ViewControllerContainer {
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


