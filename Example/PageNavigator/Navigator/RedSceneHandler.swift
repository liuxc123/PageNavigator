//
//  RedSceneHandler.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PageNavigator

extension SceneName {
    static let red: SceneName = "red"
}

class RedSceneHandler: SceneHandler {
    var name: SceneName {
        return .red
    }

    func view(with parameters: Parameters = [:]) -> UIViewController {
        let view = NavigatorFlowCollection.loadFromStoryBoard()
        view.color = .red
        if let state = parameters[CollectionSceneHandler.Parameter.stateLabel] as? String {
            view.stateText = state
        }
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        view.title = "Red"
        return view
    }

}
