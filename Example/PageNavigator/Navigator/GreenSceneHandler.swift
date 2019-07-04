//
//  GreenSceneHandler.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PageNavigator

extension SceneName {
    static let green: SceneName = "green"
}

class GreenSceneHandler: SceneHandler {
    var name: SceneName {
        return .green
    }

    func view(with parameters: Parameters = [:]) -> UIViewController {
        let view = NavigatorFlowCollection.loadFromStoryBoard()
        view.color = .green

        if let state = parameters[CollectionSceneHandler.Parameter.stateLabel] as? String {
            view.stateText = state
        }

        view.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 2)
        view.title = "Green"
        return view
    }

}
