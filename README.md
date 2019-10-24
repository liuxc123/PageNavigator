# PageNavigator

A simple app internal navigation framework to replace the cumbersome navigation logic.

[中文文档](https://github.com/liuxc123/PageNavigator/blob/master/README_CN.md)

## Requirements

- iOS 8.0 later
- Swift 5.0

## Installation

```ruby
pod 'PageNavigator'
```

## How does it work

### Create a Navigator

```
/// NavigationController container based navigator
let navigator = NavNavigator(window: UIWindow())

/// TabBarController container based navigator
let navigator = TabNavigator(window: UIWindow())

/// Custom container based navigator
let navigator = ContainerNavigator(window: UIWindow())

```

The navigator is the main entry point.

### Create a Scene and register it

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

### Set root scene and navigate!

```
navigator.root(.login)
navigator.push(.someScene)
```

The root scene is the one which it's going to be set as rootViewController of the UIWindow.


## Support URL

### Register URL:

- Register url for a scene
```
navigator.register("navigator://collection") { (url, values, context) -> SceneContext? in
    return SceneContext(sceneName: .collection, parameters: url.queryParameters, type: .push, isAnimated: true)
}
```
- Register url for a handle
```
navigator.handle("navigator://toast") { (url, values, context) -> Bool in
    print("handle: \(url.queryParameters["text"] ?? "")")
    return true
}
```

### Open URL:

```
navigator.url("navigator://toast")

// or
navigator.push(for: "navigator://toast")
navigator.present(for: "navigator://toast")
```

## Features

- Present:

  ```
  navigator.present(.login)
  ```

- Present inside navigation controller:

  ```
  navigator.presentNavigation(.someScene)
  ```

- Dismiss all views:

  ```
  navigator.dismiss()
  ```

- Dismiss first view:

  ```
  navigator.dismiss()
  ```

- Dismiss by scene:

  ```
  navigator.dismiss(.someScene)
  ```

- Push:

  ```
  navigator.push(.someScene)
  ```

- Pop to root view:

  ```
  navigator.popToRoot()
  ```

- Reload:

  ```
  navigator.reload(.someScene)
  ```

  Calls the method reload from the scene handler.

- Force touch preview

  ```
  navigator.preview(.someScene, from: someViewController, at: someSourceView)
  ```

- Popover presentation:

  ```
  navigator.popover(.someScene, from: somView)
  ```

- Transition:

  ```
  navigator.transition(to: .someScene, with: someInteractiveTransition)
  ```

- View creation:

  ```
  let loginView = navigator.view(for: .login)
  ```

- Traverse (get the current stack hierarchy; sceneName and presentationType):

  ```
  navigator.traverse { state in
      if state.names.contains(.collection) {
          // Do something
      }
  }
  ```

- Relative stack navigation using builder:

  ```
  navigator.build { builder in
      builder.modal(.contact)
      builder.modalNavigation(.detail) // Modal presentation with a navigation controller.
      builder.push(.avatar)
  }
  ```

  If you use relative navigation, you can add new scenes over the current hierarchy.

- Absolute stack navigation using builder (the current stack will be recycled and reloaded if possible):

  ```
  navigator.build { builder in
      builder.root(name: .home)
      builder.modalNavigation(.login)
  }
  ```

  If you use absolute navigation, the hierarchy will be rebuilded from root. If the current hierarchy match the targeted hierarchy, the view controllers will be recycled and reloaded.

  Use absolute navigation to show a certain hierarchy no matter what is the current state.

- Operation based navigation:

  For more complex navigation you can create and concatenate operations that will be executed serially. This can be easyly archived by creating a new SceneOperation and extending the Navigator protocol.

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

- Interceptors:

  By implementing the protocol SceneOperationInterceptor you can intercept all the operations being executed by the navigator. This protocol allows you to change the behavior of the navigator in some cases.

  For example for displaying the contacts persmissions alert just before presenting some edit contact view:

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

  To start intercepting, a registration of the interceptor is needed.

  ```
  navigator.register(ContactsPermissionsInterceptor())
  ```
