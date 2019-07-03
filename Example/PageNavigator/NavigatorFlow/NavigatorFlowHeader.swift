//
//  NavigatorFlowHeader.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class NavigatorFlowHeader: UICollectionReusableView {
    lazy var sceneNameLabel: UILabel = {
        let label = UILabel(frame: self.bounds)
        label.textAlignment = .left
        label.textColor = .black
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(label)
        return label
    }()
}

