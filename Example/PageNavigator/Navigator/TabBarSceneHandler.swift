//
//  TabBarSceneHandler.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PageNavigator

extension SceneName {
    static let tabBar: SceneName = "tabbar"
}

class TabBarSceneHandler: SceneHandler {

    var name: SceneName {
        return .tabBar
    }

    func view(with parameters: Parameters) -> UIViewController {
        // custom tabbarContainer
        return GTUITabBarController()
    }

}
