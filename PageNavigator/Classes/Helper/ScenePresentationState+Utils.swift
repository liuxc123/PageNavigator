//
//  ScenePresentationState+Utils.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

// MARK: Scene

extension Scene: ScenePresentationState {
    public var name: SceneName {
        return sceneHandler.name
    }
}

// MARK: SceneState

extension SceneState: ScenePresentationState {

}

