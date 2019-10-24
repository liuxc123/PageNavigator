//
//  CollectionSceneHandler.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PageNavigator
import UIKit

extension SceneName {
    static let collection: SceneName = "collection"
}

class CollectionSceneHandler: SceneHandler {
    enum Parameter {
        static let stateLabel = "stateLabel"
    }

    var name: SceneName {
        return .collection
    }

    func view(with parameters: Parameters = [:]) -> UIViewController {
        let view = NavigatorFlowCollection.loadFromStoryBoard()
        if let state = parameters[Parameter.stateLabel] as? String {
            view.stateText = state
        }
        view.title = "collection"
        view.hidesBottomBarWhenPushed = true
        return view
    }

}
