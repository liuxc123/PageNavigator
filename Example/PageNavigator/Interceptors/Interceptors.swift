//
//  Interceptors.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import PageNavigator

class Interceptor: SceneOperationInterceptor {
    func operation(for operation: SceneOperation, with context: SceneOperationContext) -> SceneOperation? {
        print("Interceptor \(type(of: operation)) with final context \(context.targetState.names)")
        return operation
    }

    func shouldIntercept(_ operation: SceneOperation, with context: SceneOperationContext) -> Bool {
        ///打开外链时候需要登录
        return context.targetState.names.contains(.webview)
    }
}
