//
//  ScenePresentationState.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public protocol ScenePresentationState {
    var name: SceneName { get }
    var type: ScenePresentationType { get }
}
