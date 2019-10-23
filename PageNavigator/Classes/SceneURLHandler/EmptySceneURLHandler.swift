//
//  EmptySceneURLHandler.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public struct EmptySceneURLHandler: SceneURLHandler {

    public init() {

    }

    public func sceneContexts(from url: URLConvertible) -> [SceneContext] {
        return []
    }

}
