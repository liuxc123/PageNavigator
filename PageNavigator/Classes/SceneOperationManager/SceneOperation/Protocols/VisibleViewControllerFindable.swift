//
//  VisibleViewControllerFindable.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

public protocol VisibleViewControllerFindable: NextViewControllerFindable {
    func visible(from fromViewController: UIViewController) -> UIViewController
}

// MARK: Default implementation

public extension VisibleViewControllerFindable {
    func visible(from fromViewController: UIViewController) -> UIViewController {
        var _next = fromViewController

        while let next = next(before: _next) {
            _next = next
        }

        return _next
    }
}


