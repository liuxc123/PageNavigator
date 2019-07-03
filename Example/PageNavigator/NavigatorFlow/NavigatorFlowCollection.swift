//
//  NavigatorFlowCollection.swift
//  Navigator_Example
//
//  Created by liuxc on 2019/7/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import PageNavigator

class NavigatorFlowCollection: UIViewController {
    private enum Constants {
        static let cellIdentifier = "Cell"
        static let headerIdentifier = "Header"
        static let stateLabelIdentifier = "StateLabel"

        static let defaultStateText = "root"

        static var _navigationStackCount = 1

        static var navigationStackCount: Int {
            defer { _navigationStackCount += 1 }
            return _navigationStackCount
        }

        static var rootParameters: Parameters {
            return [CollectionSceneHandler.Parameter.stateLabel: "\(Constants.defaultStateText) \(navigationStackCount)"]
        }

        static var modalParameters: Parameters {
            return [CollectionSceneHandler.Parameter.stateLabel: "modal \(navigationStackCount)"]
        }

        static var pushParameters: Parameters {
            return [CollectionSceneHandler.Parameter.stateLabel: "push \(navigationStackCount)"]
        }

        static var modalNavParameters: Parameters {
            return [CollectionSceneHandler.Parameter.stateLabel: "modalNav \(navigationStackCount)"]
        }

        static var transitionParameters: Parameters {
            return [CollectionSceneHandler.Parameter.stateLabel: "transition \(navigationStackCount)"]
        }

        static var popoverParameters: Parameters {
            return [CollectionSceneHandler.Parameter.stateLabel: "popover \(navigationStackCount)"]
        }

        static func rootSetParameters(index: Int) -> Parameters {
            return [CollectionSceneHandler.Parameter.stateLabel: "root set \(index + 1) scenes \(navigationStackCount)"]
        }
    }

    let transition = LeftTransition()
    let sections = NavigatorFlowSection.all

    // @IBOutlet
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    // Properties
    var stateText = Constants.defaultStateText
    var color = UIColor.random

    static func loadFromStoryBoard() -> NavigatorFlowCollection {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Collection") as! NavigatorFlowCollection
    }
}

// MARK: View life cycle

extension NavigatorFlowCollection {
    override func viewDidLoad() {
        super.viewDidLoad()

        stateLabel.text = stateText
        stateLabel.accessibilityIdentifier = Constants.stateLabelIdentifier
        automaticallyAdjustsScrollViewInsets = false
        collectionView.register(NavigatorFlowCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }
}

// MARK: UICollectionViewDataSource

extension NavigatorFlowCollection: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].sequences.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionElementKindSectionHeader else {
            return UICollectionReusableView()
        }

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.headerIdentifier, for: indexPath) as! NavigatorFlowHeader
        header.sceneNameLabel.text = sections[indexPath.section].name

        return header

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as! NavigatorFlowCell

        let sequence = sections[indexPath.section].sequences[indexPath.item]
        cell.sceneNameLabel.text = sequence.name
        cell.sceneNameLabel.backgroundColor = color

        if sequence.hasPreview {
            navigator.registerPreview(.collection, type: .modal, from: self, sourceView: cell)
        } else {
            navigator.unregisterPreview(sourceView: cell)
        }

        return cell
    }
}

// MARK: UICollectionViewDataSource

extension NavigatorFlowCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sequence = sections[indexPath.section].sequences[indexPath.item]

        for context in sequence.contexts {
            switch context.presentation {
            case .modal:
                navigator.present(.collection, parameters: Constants.modalParameters, animated: context.animated)
            case .push:
                navigator.push(.collection, parameters: Constants.pushParameters, animated: context.animated)
            case .set(let scenes):
                navigator.build { builder in
                    builder.root(.tabBar, parameters: Constants.rootParameters)
                    builder.tab(.blue)
                    for (index, scene) in scenes.enumerated() {
                        builder.present(scene, parameters: Constants.rootSetParameters(index: index), animated: context.animated)
                    }
                }
            case .modalNavigation:
                navigator.presentNavigation(.collection, parameters: Constants.modalNavParameters, animated: context.animated)
            case .pop:
                navigator.pop(animated: context.animated)
            case .popToRoot:
                navigator.popToRoot(animated: context.animated)
            case .dismissScene:
                navigator.dismiss(.collection, animated: context.animated)
            case .dismissFirst:
                navigator.dismiss(animated: context.animated)
            case .dismissAll:
                navigator.dismissAll(animated: context.animated)
            case .transition:
                navigator.transition(to: .collection, parameters: Constants.transitionParameters, with: transition)
            case .popover:
                let cell = collectionView.cellForItem(at: indexPath)!
                navigator.popover(.collection, parameters: Constants.popoverParameters, from: cell)
            case .deeplink:
                assertionFailure("Not yet url")
            case .preview:
                navigator.present(.collection, parameters: Constants.modalParameters, animated: context.animated)
            case .rootModal:
                navigator.build { builder in
                    builder.root(.tabBar, parameters: Constants.rootParameters)
                    builder.tab(.blue)
                    builder.present(.collection, parameters: Constants.modalParameters)
                }
            case .rootModalNav:
                navigator.build { builder in
                    builder.root(.tabBar, parameters: Constants.rootParameters)
                    builder.tab(.blue)
                    builder.presentNavigation(.collection, parameters: Constants.modalNavParameters)
                }
            case .rootModalNavPush:
                navigator.build { builder in
                    builder.root(.tabBar, parameters: Constants.rootParameters)
                    builder.tab(.blue)
                    builder.presentNavigation(.collection, parameters: Constants.modalNavParameters)
                    builder.push(.collection, parameters: Constants.pushParameters)
                }
            }
        }
    }
}
