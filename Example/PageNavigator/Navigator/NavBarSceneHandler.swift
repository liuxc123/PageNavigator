//
//  NavBarSceneHandler.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PageNavigator

extension SceneName {
    static let navBar: SceneName = "navbar"
}

class NavBarSceneHandler: SceneHandler {
    var name: SceneName {
        return .navBar
    }

    func view(with parameters: Parameters = [:]) -> UIViewController {
        return NavigationBarContainer()
    }
    
}

