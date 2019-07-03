//
//  ScenePresentationType.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public enum ScenePresentationType: String {
    case root
    case push
    case modal
    case modalNavigation
    case select
}

// MARK: Hashable

extension ScenePresentationType: Hashable {
    public static func ==(lhs: ScenePresentationType, rhs: ScenePresentationType) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    public var hashValue: Int {
        return rawValue.hashValue
    }
}
