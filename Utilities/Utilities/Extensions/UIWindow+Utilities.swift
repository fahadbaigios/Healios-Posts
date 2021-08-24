
//
//  UIWindow.swift
//  Utilities
//
//  Created by Mansoor Ali on 24/04/2019.
//  Copyright © 2019 Incubasys. All rights reserved.
//

import UIKit

public extension UIWindow {

	/// Set window rootController, make it key and visible
	///
	/// - Parameters:
	///   - viewController: rootContoller
	///   - animated: isAnimated
	///   - duration: animation duration
	///   - options: animation options
	func transition(toViewController viewController: UIViewController, duration: Double = 0.5, options: AnimationOptions? = nil) {
		self.rootViewController = viewController
		self.makeKeyAndVisible()

		guard let animationOptions = options else { return }
		transitionAnimation(duration: duration, options: animationOptions)
	}


	func transitionAnimation(duration: Double, options: AnimationOptions) {
		UIView.transition(with: self,
						  duration: duration,
						  options: options,
						  animations: nil,
						  completion: nil)
	}
}
