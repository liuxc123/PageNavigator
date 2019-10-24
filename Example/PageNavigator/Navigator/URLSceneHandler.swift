//
//  URLHandler.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PageNavigator

public class URLSceneHandler: SceneURLHandler {

    /// 这里处理特殊的url定义
    public func sceneContexts(from url: URLConvertible) -> [SceneContext] {
        return []
    }
}
