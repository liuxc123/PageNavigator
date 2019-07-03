//
//  OrderedSceneOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

struct OrderedSceneOperation: SceneOperation {
    let first: SceneOperation
    let last: SceneOperation

    init(first: SceneOperation, last: SceneOperation) {
        self.first = first
        self.last = last
    }
}

// MARK: SceneOperation methods

extension OrderedSceneOperation {
    func execute(with completion: CompletionBlock?) {
        first.execute {
            self.last.execute {
                completion?()
            }
        }
    }
}
