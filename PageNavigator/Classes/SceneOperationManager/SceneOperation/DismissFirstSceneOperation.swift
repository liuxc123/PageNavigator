//
//  DismissFirstSceneOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

struct DismissFirstSceneOperation {
    private let animated: Bool
    private let manager: SceneOperationManager

    init(animated: Bool, manager: SceneOperationManager) {
        self.animated = animated
        self.manager = manager
    }
}

// MARK: SceneOperation methods

extension DismissFirstSceneOperation: InterceptableSceneOperation {
    func execute(with completion: CompletionBlock?) {
        logTrace("[DismissFirstSceneOperation] Executing operation")

        guard let visibleNavigationController = manager.visibleNavigationController else {
            logTrace("[DismissAllOperation] No visible navigation controller found")
            completion?()
            return
        }

        let visibleViewController = manager.visible(from: visibleNavigationController)

        if visibleViewController.isBeingDisplayedModally {
            logTrace("[DismissFirstSceneOperation] Dismissing scene \(String(describing: visibleViewController.sceneName))")
            visibleViewController.dismiss(animated: animated, completion: completion)
        } else {
            logTrace("[DismissFirstSceneOperation] Could not dismiss first viewController")
            completion?()
        }
    }

    func context(from: [SceneState]) -> SceneOperationContext {
        return SceneOperationContext(currentState: from, targetState: from.dropping(first: .modal))
    }
}

