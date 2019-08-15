# PageNavigator

一个简单的应用程序内部导航框架，取代了复杂的导航逻辑。

## 版本要求

- iOS 8.0 以后
- Swift 4.2 以上

## Cocoapods 安装

```ruby
pod 'PageNavigator'
```

## 用法

### 创建一个 Navigator

```
/// NavigationController 作为容器的 navigator
let navigator = NavNavigator(window: UIWindow())

/// TabBarController 作为容器的 navigator
let navigator = TabNavigator(window: UIWindow())

/// 自定义容器的 navigator
let navigator = ContainerNavigator(window: UIWindow())

```

`navigator` 是最主要的入口

### 创建一个登录场景并注册它

```
extension SceneName {
    static let login: SceneName = "Login"
}

class LoginScene: SceneHandler {
    var name: SceneName {
        return .login
    }

    func view(with parameters: Parameters) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }

    /// Optional
    func reload(_ viewController: UIViewController, parameters: Parameters) {
        // Do nothing by default
    }

    /// Optional
    var isReloadable: Bool {
        return true
    }
}

```

```
navigator.register(LoginScene())
```

### 设置导航跟视图

```
navigator.root(.login)
navigator.push(.someScene)
```

根场景将被设置为 UIWindow 的 rootViewController。

## 特点

- Present:

```
navigator.present(.login)
```

- Present 包含 navigation controller:

```
navigator.presentNavigation(.someScene)
```

- dismiss 所有页面:

```
navigator.dismiss()
```

- Dismiss 第一个页面:

```
navigator.dismiss()
```

- Dismiss 某一个页面:

```
navigator.dismiss(.someScene)
```

- Push:

```
navigator.push(.someScene)
```

- Pop 到根视图:

```
navigator.popToRoot()
```

- Reload 重新加载:

```
navigator.reload(.someScene)
```

Calls the method reload from the scene handler.

- URLs url 跳转:

  在创建 Navigator 时创建一个`urlHandler` 实现`SceneURLHandler`协议
  自定义跳转协议

```
navigator.url(someURL)
```

- 3DTouch 预览

```
navigator.preview(.someScene, from: someViewController, at: someSourceView)
```

- 气泡展示:

```
navigator.popover(.someScene, from: somView)
```

- 场景过渡:

  自定义 Tansition 类, 并且实现 Transition 协议

```
navigator.transition(to: .someScene, with: someInteractiveTransition)
```

- 创建一个场景，获取对应的类:

```
let loginView = navigator.view(for: .login)
```

- 遍历获取当前堆栈的层次结构`sceneName`和`presentationType`

```
navigator.traverse { state in
    if state.names.contains(.collection) {
        // Do something
    }
}
```

- 使用 builder 的相对堆栈导航:

```
navigator.build { builder in
    builder.modal(.contact)
    builder.modalNavigation(.detail) // 模态展示一个包含导航控制器的视图.
    builder.push(.avatar)
}
```

如果使用相对导航，可以在当前层次结构上添加新场景。

- 使用 builder 在绝对导航中进行操作

  ```
  navigator.build { builder in
      builder.root(name: .home)
      builder.modalNavigation(.login)
  }
  ```

  如果使用绝对导航，将从根视图重新构建层次结构。如果当前层次结构与目标层次结构匹配，视图控制器将被回收并重新加载。

  无论当前状态如何，都要使用绝对导航来显示某个层次结构。

- 自定义导航行为:

  对于更复杂的导航，您可以创建并连接将串行执行的操作。通过创建一个新的 SceneOperation 并扩展 Navigator 协议，可以轻松地对其进行归档。

```
class SomeOperation {
    fileprivate var scenes: [Scene]
    fileprivate let renderer: SceneRenderer

    init(scenes: [Scene], renderer: SceneRenderer) {
        self.scenes = scenes
        self.renderer = renderer
    }
}

extension SomeOperation: SceneOperation {
    func execute(with completion: CompletionBlock?) {
        let dismissAllOperation = renderer.dismissAll(animated: true)
        let addScenes = renderer.add(scenes: scenes)
        let reloadLast = renderer.reload(scene: scenes.last!)

        let complexOperation = dismissAllOperation
        .then(addScenes)
        .then(reloadLast)
        .execute(with: completion)
    }
}
```

- 拦截器:

通过实现协议`SceneOperationInterceptor`，您可以拦截导航器执行的所有操作。该协议允许您在某些情况下更改导航器的行为。

例如，在显示一些编辑联系人视图之前显示联系人丢失警告:

```
class ContactsPermissionsInterceptor: SceneOperationInterceptor {
    func operation(with operation: SceneOperation, context: SceneOperationContext) -> SceneOperation? {
        return ShowContactPermissionsIfNeededSceneOperation().then(operation)
    }

    func shouldIntercept(operation: SceneOperation, context: SceneOperationContext) -> Bool {
        return context.targetState.names.contains(.editContact)
    }
}
```

If you want to stop the execution of the operation, you must return nil on operation(with:context:)

如果您想停止操作的执行，您必须在`operation(for operation: with context:)`操作上返回 nil

要开始使用拦截，需要对拦截器进行注册。

```
navigator.register(ContactsPermissionsInterceptor())
```
