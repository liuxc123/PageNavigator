//
//  SetVisibleSceneOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

struct SetVisibleSceneOperation {
    private let viewController: UIViewController
    private let animated: Bool
    private let manager: SceneOperationManager

    init(viewController: UIViewController,
         animated: Bool,
         manager: SceneOperationManager) {
        self.viewController = viewController
        self.animated = animated
        self.manager = manager
    }
}

// MARK: SceneOperation methods

extension SetVisibleSceneOperation: SceneOperation {
    func execute(with completion: CompletionBlock?) {
        logTrace("[SetVisibleSceneOperation] Executing operation")

        let group = DispatchGroup()

        if let presentingViewController = viewController.presentedViewController?.presentingViewController {
            group.enter()
            presentingViewController.dismiss(animated: animated, completion: group.leave)
        }

        if let navigationController = viewController.navigationController {
            group.enter()
            CATransaction.begin()
            navigationController.popToViewController(viewController, animated: animated)
            CATransaction.setCompletionBlock(group.leave)
            CATransaction.commit()
        }

        DispatchQueue.global().async {
            group.wait()
            DispatchQueue.main.async { completion?() }
        }
    }
}

