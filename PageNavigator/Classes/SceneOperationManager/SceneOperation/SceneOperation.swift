//
//  SceneOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public protocol SceneOperation {
    func execute(with completion: CompletionBlock?)
    func then(_ operation: SceneOperation) -> SceneOperation
}

