//
//  SceneOperationInterceptable.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public protocol InterceptableSceneOperation: SceneOperation {
    func context(from: [SceneState]) -> SceneOperationContext
}

