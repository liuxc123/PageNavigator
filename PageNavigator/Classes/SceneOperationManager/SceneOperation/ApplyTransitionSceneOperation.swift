//
//  ApplyTransitionSceneOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

struct ApplyTransitionSceneOperation {
    private let transition: Transition
    private let scene: Scene
    private let manager: SceneOperationManager

    init(transition: Transition, to scene: Scene, manager: SceneOperationManager) {
        self.transition = transition
        self.scene = scene
        self.manager = manager
    }
}

// MARK: SceneOperation methods

extension ApplyTransitionSceneOperation: InterceptableSceneOperation {
    func execute(with completion: CompletionBlock?) {
        logTrace("[AddSceneOperation] Executing operation")
        scene.operationParameters[ParametersKeys.transition] = transition
        manager.add(scenes: [scene]).execute(with: completion)
    }

    func context(from: [SceneState]) -> SceneOperationContext {
        return SceneOperationContext(currentState: from, targetState: from.appending(scene))
    }
}
