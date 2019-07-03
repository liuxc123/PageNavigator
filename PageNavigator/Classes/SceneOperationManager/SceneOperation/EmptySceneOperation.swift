//
//  EmptySceneOperation.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

struct EmptySceneOperation: SceneOperation {
    func execute(with completion: CompletionBlock?) {
        completion?()
    }
}
