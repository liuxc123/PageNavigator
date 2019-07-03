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

    /// 全局的url处理
    /// url格式scheme://host:port/path/?query#fragement
    /// 例子：navigator://collection?query#push
    /// 内部: navigator://red?user_id=11&user_name=Navigator#modal
    /// 外部：http(https)://www.baidu.com#modalNavigation
    public func sceneContexts(from url: URL) -> [SceneContext] {

        if url.scheme == "http" || url.scheme == "https" {
            let navType = ScenePresentationType(rawValue: url.fragment ?? "") ?? .push

            return [
                SceneContext(sceneName: .webview, parameters: ["url": url], type: navType, isAnimated: true)
            ]
        }

        if url.scheme == "webus" {
            let name = SceneName(url.host! + url.path)
            if navigator.canRoute(name) {
                let navType = ScenePresentationType(rawValue: url.fragment ?? "") ?? .push

                return [
                    SceneContext(sceneName: name, parameters: ["url": url], type: navType, isAnimated: true)
                ]
            }
        }

        return []
    }

}
