//
//  SetScenesOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

struct SetScenesOperation {
    private var scenes: [Scene]
    private let manager: SceneOperationManager

    init(scenes: [Scene], manager: SceneOperationManager) {
        self.scenes = scenes
        self.manager = manager
    }
}

// MARK: SceneOperation methods

extension SetScenesOperation: InterceptableSceneOperation {
    func execute(with completion: CompletionBlock?) {
        logTrace("[SetScenesOperation] Executing operation")
        guard let rootScene = scenes.first else {
            logTrace("[SetScenesOperation] No scenes to set")
            completion?()
            return
        }

        if isRootViewController(matching: rootScene) {
            logTrace("[SetScenesOperation] Stack can be recycled")
            manager
                .recycle(scenes: scenes)
                .execute(with: completion)
        } else {
            logTrace("[SetScenesOperation] Stack can't be recycled")
            manager
                .dismissAll(animated: false)
                .then(manager.add(scenes: scenes))
                .execute(with: completion)
        }
    }

    func context(from: [SceneState]) -> SceneOperationContext {
        return SceneOperationContext(currentState: from, targetState: scenes)
    }
}

// MARK: Private methods

extension SetScenesOperation {
    /// Returns true if the rootViewController in Window is handled by the scene
    func isRootViewController(matching scene: Scene) -> Bool {
        return manager.rootViewController?.sceneName == scene.sceneHandler.name.value
    }
}

