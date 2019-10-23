import Foundation
import UIKit

public typealias URLPattern = String
public typealias URLSceneContextFactory = (_ url: URLConvertible, _ values: [String: Any], _ context: Any?) -> SceneContext?
public typealias URLOpenHandlerFactory = (_ url: URLConvertible, _ values: [String: Any], _ context: Any?) -> Bool
public typealias URLOpenHandler = () -> Bool

public protocol URLNavigatorType {
    var matcher: URLMatcher { get }

    func register(_ pattern: URLPattern, _ factory: @escaping URLSceneContextFactory)

    func handle(_ pattern: URLPattern, _ factory: @escaping URLOpenHandlerFactory)

    func handler(for url: URLConvertible, context: Any?) -> URLOpenHandler?

    func sceneContext(for url: URLConvertible, context: Any?) -> SceneContext?
}

open class URLSceneProvider: URLNavigatorType {

    public let matcher = URLMatcher()

    private var sceneContextFactories = [URLPattern: URLSceneContextFactory]()
    private var handlerFactories = [URLPattern: URLOpenHandlerFactory]()

    public init() {
      // ⛵ I'm a URLSceneProvider!
    }

    open func register(_ pattern: URLPattern, _ factory: @escaping URLSceneContextFactory) {
        self.sceneContextFactories[pattern] = factory
    }

    public func handle(_ pattern: URLPattern, _ factory: @escaping URLOpenHandlerFactory) {
        self.handlerFactories[pattern] = factory
    }

    public func sceneContext(for url: URLConvertible, context: Any? = nil) -> SceneContext? {
        let urlPatterns = Array(self.sceneContextFactories.keys)
        guard let match = self.matcher.match(url, from: urlPatterns) else { return nil }
        guard let factory = self.sceneContextFactories[match.pattern] else { return nil }
        return factory(url, match.values, context)
    }

    public func handler(for url: URLConvertible, context: Any? = nil) -> URLOpenHandler? {
        let urlPatterns = Array(self.handlerFactories.keys)
        guard let match = self.matcher.match(url, from: urlPatterns) else { return nil }
        guard let handler = self.handlerFactories[match.pattern] else { return nil }
        return { handler(url, match.values, context) }
    }

    func canSceneRoute(for url: URLConvertible) -> Bool {
        return (sceneContext(for: url) != nil)
    }

    func canHandleRoute(for url: URLConvertible) -> Bool {
        return (handler(for: url, context: nil) != nil)
    }

    func canRoute(for url: URLConvertible) -> Bool {
        return canHandleRoute(for: url) || canSceneRoute(for: url)
    }

}

