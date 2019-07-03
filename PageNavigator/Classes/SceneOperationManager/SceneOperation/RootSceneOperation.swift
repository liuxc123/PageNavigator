//
//  RootSceneOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

class RootSceneOperation {
    private let scene: Scene
    private let manager: SceneOperationManager

    init(scene: Scene, manager: SceneOperationManager) {
        self.scene = scene
        self.manager = manager
    }
}

// MARK: SceneOperation methods

extension RootSceneOperation: InterceptableSceneOperation {
    func execute(with completion: CompletionBlock?) {
        logTrace("[RootSceneOperation] Executing operation")

        guard let viewControllerContainer = scene.view() as? ViewControllerContainer else {
            logError("[RootSceneOperation] View builded from \(scene) is not a ViewControllerContainer")
            completion?()
            return
        }

        if !manager.canReused(container: viewControllerContainer) {
            logDebug("[RootSceneOperation] Current ViewControllerContainer can't be reused for scene \(scene)")
            manager.set(container: viewControllerContainer)
        } else {
            logDebug("[RootSceneOperation] Current ViewControllerContainer will be reused for scene \(scene)")
        }

        completion?()
    }

    func context(from: [SceneState]) -> SceneOperationContext {
        return SceneOperationContext(currentState: from, targetState: [scene])
    }
}

