//
//  TraverseSceneOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

public typealias TraverseBlock = ([ScenePresentationState]) -> Void

public struct TraverseSceneOperation {
    private let traverseBlock: TraverseBlock
    private let manager: SceneOperationManager

    public init(traverseBlock: @escaping TraverseBlock, manager: SceneOperationManager) {
        self.traverseBlock = traverseBlock
        self.manager = manager
    }
}

// MARK: SceneOperation methods

extension TraverseSceneOperation: InterceptableSceneOperation {
    public func execute(with completion: CompletionBlock?) {
        logTrace("[TraverseSceneOperation] Executing operation")

        let state = manager.state(from: manager.rootViewController)

        traverseBlock(state)
        completion?()
    }

    public func context(from: [SceneState]) -> SceneOperationContext {
        return SceneOperationContext(currentState: from, targetState: from)
    }
}

