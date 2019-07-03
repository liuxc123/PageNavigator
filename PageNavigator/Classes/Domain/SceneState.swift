//
//  SceneState.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public struct SceneState {
    public let name: SceneName
    public let type: ScenePresentationType

    public init(name: SceneName, type: ScenePresentationType) {
        self.name = name
        self.type = type
    }
}

extension SceneState: CustomStringConvertible {
    public var description: String {
        return "(name: \(name), type: \(type))"
    }
}
