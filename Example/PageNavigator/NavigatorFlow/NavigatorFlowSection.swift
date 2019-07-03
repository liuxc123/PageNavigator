//
//  NavigatorFlowSection.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

struct NavigatorFlowSection {
    let name: String
    let sequences: [NavigatorFlowSequence]
}

extension NavigatorFlowSection {
    static let all: [NavigatorFlowSection] = [
        NavigatorFlowSection(name: "Test sequences", sequences: NavigatorFlowSequence.testSequences),
        NavigatorFlowSection(name: "Base sequences", sequences: NavigatorFlowSequence.baseSequences),
        NavigatorFlowSection(name: "Non animated sequences", sequences: NavigatorFlowSequence.nonAnimatedSequences),
    ]
}
