//
//  Preview.swift
//  Navigator
//
//  Created by liuxc on 2019/7/2.
//  Copyright © 2019 liuxc. All rights reserved.
//

import Foundation
import UIKit

public class Preview: NSObject {
    private var scene: Scene
    private var completion: CompletionBlock?
    private var fromViewController: UIViewController
    private var context: UIViewControllerPreviewing?
    var isPeeking: Bool

    init(scene: Scene,
         fromViewController: UIViewController,
         completion: CompletionBlock? = nil,
         isPeeking: Bool = false) {
        self.scene = scene
        self.completion = completion
        self.fromViewController = fromViewController
        self.isPeeking = isPeeking
    }
}

extension Preview {
    func register(from view: UIView) {
        if #available(iOS 9.0, *) {
            context = fromViewController.registerForPreviewing(with: self, sourceView: view)
        }
    }

    func unregister(from view: UIView) {
        guard let context = context else { return }

        if #available(iOS 9.0, *) {
            fromViewController.unregisterForPreviewing(withContext: context)
        } 
    }
}

extension Preview: UIViewControllerPreviewingDelegate {
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                                  viewControllerForLocation location: CGPoint) -> UIViewController? {
        isPeeking = true
        return scene.view()
    }

    public func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                                  commit viewControllerToCommit: UIViewController) {
        switch scene.type {
        case .push:
            fromViewController.show(viewControllerToCommit, sender: nil)
        case .modal:
            fromViewController.present(viewControllerToCommit, animated: scene.isAnimated, completion: completion)
        case .modalNavigation:
            let navigation = scene.sceneHandler.navigation(with: viewControllerToCommit)
            fromViewController.present(navigation, animated: scene.isAnimated, completion: completion)
        case .root, .select:
            completion?()
            break
        }

        isPeeking = false
    }

    func update(with preview: Preview) {
        scene = preview.scene
        fromViewController = preview.fromViewController
        completion = preview.completion
    }
}
