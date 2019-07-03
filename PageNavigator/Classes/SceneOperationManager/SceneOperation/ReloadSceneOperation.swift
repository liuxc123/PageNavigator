//
//  ReloadSceneOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

class ReloadSceneOperation {
    private let scene: Scene
    private let manager: SceneOperationManager

    init(scene: Scene, manager: SceneOperationManager) {
        self.scene = scene
        self.manager = manager
    }
}

// MARK: SceneOperation methods

extension ReloadSceneOperation: InterceptableSceneOperation {
    func execute(with completion: CompletionBlock?) {
        logTrace("[ReloadSceneOperation] Executing operation")

        guard let visibleNavigationController = manager.visibleNavigationController else {
            logTrace("[ReloadSceneOperation] No visible navigation controller found")
            completion?()
            return
        }

        let visibleViewController = manager.visible(from: visibleNavigationController)

        if scene.sceneHandler.name.value == visibleViewController.sceneName, scene.sceneHandler.isReloadable {
            scene.sceneHandler.reload(visibleViewController, parameters: scene.parameters)
        }

        completion?()
    }

    func context(from: [SceneState]) -> SceneOperationContext {
        return SceneOperationContext(currentState: from, targetState: from)
    }
}
