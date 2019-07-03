//
//  SceneOperationInterceptor.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public protocol SceneOperationInterceptor: class {
    func operation(for operation: SceneOperation, with context: SceneOperationContext) -> SceneOperation?
    func shouldIntercept(_ operation: SceneOperation, with context: SceneOperationContext) -> Bool
}

// MARK: Public methods

public extension SceneOperationInterceptor {
    func operation(for operation: SceneOperation, with context: SceneOperationContext) -> SceneOperation? {
        return operation
    }

    func shouldIntercept(_ operation: SceneOperation, with context: SceneOperationContext) -> Bool {
        return false
    }
}
