//
//  SceneOperationContext.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public struct SceneOperationContext {
    public static let empty = SceneOperationContext(currentState: [], targetState: [])

    public let currentState: [ScenePresentationState]
    public let targetState: [ScenePresentationState]
}
