//
//  AppFlow.swift
//  Template
//
//  Created by Fahad Baig on 02/02/2018.
//  Copyright © 2018 Fahad Baig. All rights reserved.
//

import RxFlow
import RxCocoa
import RxSwift
import UIKit
import Store

public class AppStepper: Stepper {
    public var steps = PublishRelay<Step>()
    public var initialStep: Step = AppStep.posts
    public init() {}
}

class AppFlow: BaseFlow {

    override var root: Presentable {
        return rootViewController
    }

    let rootViewController: UINavigationController = {
        let scene = UINavigationController()
        return scene
    }()

    weak var window: UIWindow!
	private let store: PostsStore

    init(withWindow window: UIWindow) {
        self.window = window
        window.rootViewController = rootViewController
		store = PostsStore()
    }

    //MARK:-  navigation to flow
    override func navigateToAppStep(step: AppStep) -> FlowContributors {
        switch step {
        case .posts:
            return navigateToPostsScene()
		case .postDetail(let post):
			return navigateToPostDetailScene(post: post)
        }
    }

    //MARK:- Scenes
    private func navigateToPostsScene() -> FlowContributors {
        let vm = PostsViewModel.init(store: store)
        let scene = PostsViewController.instantiate(withViewModel: vm)

        rootViewController.setViewControllers([scene], animated: false)
        let flowContributor = FlowContributor.contribute(withNextPresentable: scene, withNextStepper: vm)
        return FlowContributors.one(flowContributor: flowContributor)
    }

	private func navigateToPostDetailScene(post: PostMO) -> FlowContributors {
        let vm = PostDetailViewModel(post: post, store: store)
        let scene = PostDetailViewController.instantiate(withViewModel: vm)

        rootViewController.pushViewController(scene, animated: true)
        let flowContributor = FlowContributor.contribute(withNextPresentable: scene, withNextStepper: vm)
        return FlowContributors.one(flowContributor: flowContributor)
    }
}

