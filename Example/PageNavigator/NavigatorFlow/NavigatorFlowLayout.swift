//
//  NavigatorFlowLayout.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class NavigatorFlowLayout: UICollectionViewFlowLayout {
    var items: CGFloat {
        return 4
    }

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let width = (collectionView.bounds.width - items) / items
        itemSize = CGSize(width: width, height: width)
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        sectionHeadersPinToVisibleBounds = true
    }
}

