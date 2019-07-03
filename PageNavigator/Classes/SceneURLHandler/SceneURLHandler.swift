//
//  SceneURLHandler.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public protocol SceneURLHandler {
    func sceneContexts(from url: URL) -> [SceneContext]
}
