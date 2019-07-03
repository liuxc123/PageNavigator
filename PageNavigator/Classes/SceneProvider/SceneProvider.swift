//
//  SceneProvider.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public class SceneProvider {
    public let manager: SceneOperationManager

    /// Contains all the scenes registered in the system by their name.
    private var sceneHandlersByName: [SceneName: SceneHandler] = [:]

    public init(manager: SceneOperationManager) {
        self.manager = manager
    }
}

// MARK: Internal Methods

extension SceneProvider {
    func register(_ sceneHandler: SceneHandler) {
        assert(sceneHandlersByName[sceneHandler.name] == nil, "Already registered scene named \(sceneHandler.name)")
        sceneHandlersByName[sceneHandler.name] = sceneHandler
    }

    func canRoute(_ name: SceneName) -> Bool {
        return sceneHandlersByName[name] != nil
    }

    func scenes<T>(with builder: SceneBuilderBlock<T>) -> (scenes: [Scene], isAbsolutely: Bool) {
        let sceneBuilder = SceneBuilder(using: builder, sceneProvider: self)
        return (sceneBuilder.scenes, sceneBuilder.isAbsolute)
    }

    func scene(with name: SceneName, parameters: Parameters = [:], type: ScenePresentationType, animated: Bool = true) -> Scene {
        guard let sceneHandler = sceneHandlersByName[name] else {
            fatalError("The scene \(name) is not registered.")
        }
        return Scene(sceneHandler: sceneHandler, parameters: parameters, type: type, animated: animated)
    }

    func scene(with sceneContext: SceneContext) -> Scene {
        guard let sceneHandler = sceneHandlersByName[sceneContext.sceneName] else {
            fatalError("The scene \(sceneContext.sceneName) is not registered.")
        }
        return Scene(sceneHandler: sceneHandler, parameters: sceneContext.parameters, type: sceneContext.type, animated: sceneContext.isAnimated)
    }
}

