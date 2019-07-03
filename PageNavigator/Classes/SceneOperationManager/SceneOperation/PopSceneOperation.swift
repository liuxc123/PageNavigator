//
//  PopSceneOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

struct PopSceneOperation {
    private let popToRoot: Bool
    private let animated: Bool
    private let manager: SceneOperationManager

    init(toRoot popToRoot: Bool, animated: Bool, manager: SceneOperationManager) {
        self.popToRoot = popToRoot
        self.animated = animated
        self.manager = manager
    }
}

// MARK: SceneOperation methods

extension PopSceneOperation: InterceptableSceneOperation {
    func execute(with completion: CompletionBlock?) {
        logTrace("[PopSceneOperation] Executing operation")

        guard let rootViewController = manager.rootViewController else {
            logTrace("[PopSceneOperation] No root view controller found")
            completion?()
            return
        }

        let visibleViewController = manager.visible(from: rootViewController)

        guard let navigationController = visibleViewController.navigationController else {
            logTrace("[PopSceneOperation] No navigation controller found in the most visible view controller \(visibleViewController)")
            completion?()
            return
        }

        CATransaction.begin()
        if popToRoot {
            logTrace("[PopSceneOperation] Popping to root")
            navigationController.popToRootViewController(animated: animated)
        } else {
            navigationController.popViewController(animated: animated)
        }
        CATransaction.setCompletionBlock(completion)
        CATransaction.commit()
    }

    func context(from: [SceneState]) -> SceneOperationContext {
        let to = popToRoot
            ? from.dropping(from: .push)
            : from.dropping(first: .push)

        return SceneOperationContext(currentState: from, targetState: to)
    }
}

