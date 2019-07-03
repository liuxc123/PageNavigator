//
//  Transition.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

public protocol Transition: UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var insideNavigationBar: Bool { get }
    var modalPresentationStyle: UIModalPresentationStyle { get }
}
