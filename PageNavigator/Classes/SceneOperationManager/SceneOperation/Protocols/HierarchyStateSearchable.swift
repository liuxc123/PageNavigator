//
//  HierarchyStateSearchable.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public protocol HierarchyStateSearchable: VisibleViewControllerFindable {
    func state(from viewController: UIViewController?) -> [SceneState]
}

// MARK: Default implementation

public extension HierarchyStateSearchable {
    func state(from viewController: UIViewController?) -> [SceneState] {
        var _next = viewController
        var views: [UIViewController] = []

        while let next = _next {
            views.append(next)
            _next = self.next(before: next)
        }

        return views
            .lazy
            .map { ($0.sceneName, $0.scenePresentationType) }
            .map { $0 == nil ? nil : (SceneName($0!), $1) }
            .compactMap { $0 }
            .map(SceneState.init)
    }

    func firstViewController(matching sceneName: SceneName, from viewController: UIViewController?) -> UIViewController? {
        var _next = viewController

        while let next = _next {
            if next.sceneName == sceneName.value {
                return next
            } else {
                _next = self.next(before: next)
            }
        }

        return nil
    }
}

// MARK: Handy method

extension HierarchyStateSearchable where Self: SceneOperationManager {
    var currentState: [SceneState] {
        return state(from: rootViewController)
    }
}

