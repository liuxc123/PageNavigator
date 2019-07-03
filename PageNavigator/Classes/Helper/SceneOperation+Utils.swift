//
//  SceneOperation+Utils.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public extension SceneOperation {
    func then(_ operation: SceneOperation) -> SceneOperation {
        return OrderedSceneOperation(first: self, last: operation)
    }
}
