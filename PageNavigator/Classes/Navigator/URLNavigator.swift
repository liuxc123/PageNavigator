//
//  URLNavigator.swift
//  PageNavigator
//
//  Created by liuxc on 2019/10/23.
//

import Foundation

// MARK: Navigation judgment

public extension Navigator {
    func canRoute(for url: URLConvertible) -> Bool {
        return urlProvider.canRoute(for: url)
    }
}

// MARK: Deeplink

public extension Navigator {
    func url(_ url: URLConvertible, completion: CompletionBlock? = nil) -> Bool {
        logDebug("URL \(url)")

        // URLHandler
        var sceneContexts = urlHandler.sceneContexts(from: url)

        if sceneContexts.count != 0 {
            build { sceneContexts.forEach($0.add) }
            return true
        }

        if let sceneContext = sceneContext(for: url) {
            sceneContexts.append(sceneContext)
            build { sceneContexts.forEach($0.add) }
            return true
        }

        if let handler = handler(for: url, context: nil) {
            return  handler()
        }
        return false
    }
}

// MARK: URL Register

public extension Navigator {
    func register(_ pattern: URLPattern, _ factory: @escaping URLSceneContextFactory) {
        urlProvider.register(pattern, factory)
    }

    func handle(_ pattern: URLPattern, _ factory: @escaping URLOpenHandlerFactory) {
        urlProvider.handle(pattern, factory)
    }
}

// MARK: URL Handler

public extension Navigator {
    func sceneContext(for url: URLConvertible, context: Any? = nil) -> SceneContext? {
        return urlProvider.sceneContext(for: url, context: context)
    }

    func handler(for url: URLConvertible, context: Any? = nil) -> URLOpenHandler? {
        return urlProvider.handler(for: url, context: context)
    }
}

// MARK: Set root with Scene names

public extension Navigator {
    func root(for url: URLConvertible, context: Any? = nil) {
        logDebug("URL Root \(url)")
        guard let sceneContext = sceneContext(for: url, context: context) else { return }
        root(sceneContext.sceneName, parameters: sceneContext.parameters)
    }
}

// MARK: Navigating with Scene names

public extension Navigator {
    func push(for url: URLConvertible, context: Any? = nil, animated: Bool = true, completion: CompletionBlock? = nil) {
        logDebug("URL Push \(url)")
        guard let sceneContext = sceneContext(for: url, context: context) else { return }
        push(sceneContext.sceneName, parameters: sceneContext.parameters, animated: animated, completion: completion)
    }

    func present(for url: URLConvertible, context: Any? = nil, animated: Bool = true, completion: CompletionBlock? = nil) {
        logDebug("URL Present \(url)")
        guard let sceneContext = sceneContext(for: url, context: context) else { return }
        present(sceneContext.sceneName, parameters: sceneContext.parameters, animated: animated, completion: completion)
    }

    func presentNavigation(for url: URLConvertible, context: Any? = nil, animated: Bool = true, completion: CompletionBlock? = nil) {
        logDebug("URL Root \(url)")
        guard let sceneContext = sceneContext(for: url, context: context) else { return }
        presentNavigation(sceneContext.sceneName, parameters: sceneContext.parameters, animated: animated, completion: completion)
    }
}

// MARK: Transition
//
public extension Navigator {
    func transition(for url: URLConvertible, context: Any? = nil, with transition: Transition, completion: CompletionBlock? = nil) {
        logDebug("URL Transition \(url)")
        guard let sceneContext = sceneContext(for: url, context: context) else { return }
        let type: ScenePresentationType = transition.insideNavigationBar ? .modalNavigation : .modal
        let scene = provider.scene(with: sceneContext.sceneName, parameters: sceneContext.parameters, type: type, animated: true)
        manager.transition(transition, to: scene).execute(with: completion)
    }
}

// MARK: Popover

public extension Navigator {
    func popover(for url: URLConvertible, context: Any? = nil, with popover: Popover, completion: CompletionBlock? = nil) {
        logDebug("URL Popover \(url)")
        guard let sceneContext = sceneContext(for: url, context: context) else { return }
        let type: ScenePresentationType = popover.insideNavigationBar ? .modalNavigation : .modal
        let scene = provider.scene(with: sceneContext.sceneName, parameters: sceneContext.parameters, type: type, animated: true)
        manager.popover(popover, to: scene).execute(with: completion)
    }

    func popover(for url: URLConvertible, context: Any? = nil, from button: UIBarButtonItem, completion: CompletionBlock? = nil) {
        logDebug("URL Popover \(url) from barButtonItem")
        guard let sceneContext = sceneContext(for: url, context: context) else { return }
        let scene = provider.scene(with: sceneContext.sceneName, parameters: sceneContext.parameters, type: .modal, animated: true)

        let popover = Popover()
        popover.barButtonItem = button

        manager.popover(popover, to: scene).execute(with: completion)
    }

    func popover(for url: URLConvertible, context: Any? = nil, from view: UIView, completion: CompletionBlock? = nil) {
        logDebug("URL Popover \(url) from view")
        guard let sceneContext = sceneContext(for: url, context: context) else { return }
        let scene = provider.scene(with: sceneContext.sceneName, parameters: sceneContext.parameters, type: .modal, animated: true)
        let popover = Popover()
        popover.sourceView = view
        popover.sourceRect = view.frame
        manager.popover(popover, to: scene).execute(with: completion)
    }
}

// MARK: Reload

public extension Navigator {
    func reload(for url: URLConvertible, context: Any? = nil, completion: CompletionBlock? = nil) {
        logDebug("URL Reload \(url)")
        guard let sceneContext = sceneContext(for: url, context: context) else { return }
        reload(sceneContext.sceneName, parameters: sceneContext.parameters, completion: completion)
    }
}

// MARK: View

public extension Navigator {
    func view(for url: URLConvertible, context: Any? = nil) -> UIViewController? {
        logDebug("URL View \(url)")
        guard let sceneContext = sceneContext(for: url, context: context) else { return nil }
        return provider.scene(with: sceneContext.sceneName, parameters: sceneContext.parameters, type: .root).view()
    }
}
