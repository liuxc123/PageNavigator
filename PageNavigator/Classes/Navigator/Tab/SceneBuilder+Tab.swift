//
//  SceneBuilder+Tab.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public extension SceneBuilder where T: TabNavigator {
    func tab(_ sceneName: SceneName, parameters: Parameters = [:]) {
        add(context: SceneContext(sceneName: sceneName, parameters: parameters, type: .select, isAnimated: true))
    }

    func currentTab() {
        guard let currentTabSceneName = currentTabSceneName else { return }
        tab(currentTabSceneName)
    }
}

// MARK: Private methods

private extension SceneBuilder where T: TabNavigator {
    var currentTabSceneName: SceneName? {
        guard let name = sceneProvider
            .manager
            .visibleNavigationController?
            .viewControllers
            .first?
            .sceneName else { return nil }

        return SceneName(name)
    }
}
