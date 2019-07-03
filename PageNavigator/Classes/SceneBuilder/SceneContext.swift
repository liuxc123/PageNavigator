//
//  SceneContext.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public struct SceneContext {
    public let sceneName: SceneName
    public let parameters: Parameters
    public let type: ScenePresentationType
    public let isAnimated: Bool

    public init(sceneName: SceneName,
                parameters: Parameters = [:],
                type: ScenePresentationType = .select,
                isAnimated: Bool = true) {
        self.sceneName = sceneName
        self.parameters = parameters
        self.type = type
        self.isAnimated = isAnimated
    }

    public init(sceneState: SceneState,
                parameters: Parameters = [:],
                isAnimated: Bool = true) {
        self.sceneName = sceneState.name
        self.parameters = parameters
        self.type = sceneState.type
        self.isAnimated = isAnimated
    }
}

// MARK: Internal methods

extension SceneContext {
    init(scene: Scene) {
        self.init(sceneName: scene.sceneHandler.name,
                  parameters: scene.parameters,
                  type: scene.type,
                  isAnimated: scene.isAnimated)
    }
}

// MARK: CustomStringConvertible

extension SceneContext: CustomStringConvertible {
    public var description: String {
        return "(scenename: \(sceneName), parameters: \(parameters), type: \(type), animated: \(isAnimated))"
    }
}
