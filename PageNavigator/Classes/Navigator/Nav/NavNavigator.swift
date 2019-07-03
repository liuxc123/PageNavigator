//
//  NavNavigator.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

final public class NavNavigator: Navigator, NavigatorPreviewing {
    public var previews: [UIView : Preview] = [:]
    public var interceptors: [SceneOperationInterceptor] = []

    public let provider: SceneProvider
    public let urlHandler: SceneURLHandler
    public let manager: SceneOperationManager

    public init(window: UIWindow,
                sceneURLHandler: SceneURLHandler = EmptySceneURLHandler()) {
        let sceneOperationManager = SceneOperationManager(window: window)
        self.manager = sceneOperationManager
        self.urlHandler = sceneURLHandler

        self.provider = SceneProvider(manager: sceneOperationManager)
    }
}

