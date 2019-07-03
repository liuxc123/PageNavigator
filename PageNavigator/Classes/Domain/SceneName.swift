//
//  SceneName.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation

public struct SceneName {
    public let value: String

    public init(_ value: String) {
        self.value = value
    }
}

extension SceneName: Hashable {
    public static func == (lhs: SceneName, rhs: SceneName) -> Bool {
        return lhs.value == rhs.value
    }

    public var hashValue: Int {
        return value.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(value)
    }
}

extension SceneName: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.value = value
    }

    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }

    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
}

extension SceneName: CustomStringConvertible {
    public var description: String {
        return value
    }
}
