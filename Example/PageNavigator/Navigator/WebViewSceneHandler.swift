//
//  WebViewScene.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import PageNavigator
import SafariServices

extension SceneName {
    static let webview: SceneName = "webview"
}

class WebViewSceneHandler: SceneHandler {
    var name: SceneName {
        return .webview
    }

    func view(with parameters: Parameters = [:]) -> UIViewController {
        guard let url = parameters["url"] as? URL else {
            return SFSafariViewController(url: URL(string: "http://redirect.simba.taobao.com")!)
        }
        return SFSafariViewController(url: url)
    }
}
