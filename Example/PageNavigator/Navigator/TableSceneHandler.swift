//
//  TableSceneHandler.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PageNavigator
import UIKit

extension SceneName {
    static let table: SceneName = "table"
}

class TableSceneHandler: SceneHandler {
    enum Parameter {
        static let stateLabel = "stateLabel"
    }

    var name: SceneName {
        return .table
    }

    func view(with parameters: Parameters = [:]) -> UIViewController {
        let view = NavigatorFlowTable(style: .plain)
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 4)
        view.title = "Table"
        return view
    }

}
