//
//  BlueSceneHandler.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PageNavigator

extension SceneName {
    static let blue: SceneName = "blue"
}

class BlueSceneHandler: SceneHandler {
    var name: SceneName {
        return .blue
    }

    func view(with parameters: Parameters = [:]) -> UIViewController {
        let view = NavigatorFlowCollection.loadFromStoryBoard()
        view.color = .blue

        if let state = parameters[CollectionSceneHandler.Parameter.stateLabel] as? String {
            view.stateText = state
        }

        view.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        view.title = "Blue"
        return view
    }
}

class TestSceneHandler: SceneHandler {
    var name: SceneName {
        return "test"
    }

    func view(with parameters: Parameters) -> UIViewController {
        return UIViewController()
    }


}

