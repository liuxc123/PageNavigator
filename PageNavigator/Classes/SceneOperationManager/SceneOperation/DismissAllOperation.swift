//
//  DismissAllOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

struct DismissAllOperation {
    private let animated: Bool
    private let manager: SceneOperationManager

    init(animated: Bool, manager: SceneOperationManager) {
        self.animated = animated
        self.manager = manager
    }
}

// MARK: SceneOperation methods

extension DismissAllOperation: InterceptableSceneOperation {
    func execute(with completion: CompletionBlock?) {
        logTrace("[DismissAllOperation] Executing operation")

        guard let rootViewController = manager.rootViewController else {
            logTrace("[DismissAllOperation] No root view controller found")
            completion?()
            return
        }

        rootViewController.dismiss(animated: animated, completion: completion)

        if !animated {
            completion?()
        }
    }

    func context(from: [SceneState]) -> SceneOperationContext {
        return SceneOperationContext(currentState: from, targetState: from.dropping(from: .modal))
    }
}

