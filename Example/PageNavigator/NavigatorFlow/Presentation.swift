//
//  Presentation.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PageNavigator

enum Presentation {
    case modal
    case push
    case modalNavigation
    case set([SceneName])
    case transition
    case dismissFirst
    case dismissScene
    case dismissAll
    case pop
    case popToRoot
    case deeplink
    case preview
    case popover
    case rootModal
    case rootModalNav
    case rootModalNavPush

    var value: String {
        switch self {
        case .pop:
            return "pop"
        case .popToRoot:
            return "popToRoot"
        case .dismissScene:
            return "dismissScene"
        case .dismissFirst:
            return "dismissFirst"
        case .dismissAll:
            return "dismissAll"
        case .deeplink:
            return "deeplink"
        case .preview:
            return "preview"
        case .modal:
            return "modal"
        case .push:
            return "push"
        case .modalNavigation:
            return "modalNav"
        case .transition:
            return "transition"
        case .popover:
            return "popover"
        case .rootModal:
            return "root modal"
        case .rootModalNav:
            return "root modalNav"
        case .rootModalNavPush:
            return "root modalNav push"
        case .set(let scenes):
            return "root set \(scenes.count) scenes"
        }
    }
}

