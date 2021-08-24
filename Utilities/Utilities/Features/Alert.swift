//
//  Alert.swift
//  Utilities
//
//  Created by Mansoor Ali on 15/10/2020.
//  Copyright © 2020 Fahad Baig. All rights reserved.
//

import UIKit

/// Provide an easy way to create and present alert,sheet
public class Alert {

	/// return new UIAlertController
	/// - Parameters:
	///   - title: alert title
	///   - message: alert message
	///   - actions: alert actions array
	///   - style: alert style
	/// - Returns: new alert controller with correct configuration
	public static func new(title: String = "", message: String, actions: [UIAlertAction], style: UIAlertController.Style = .alert) -> UIAlertController {
		let alert = UIAlertController(title: title, message: message, preferredStyle: style)
		for action in actions {
			alert.addAction(action)
		}
		return alert
	}


	/// creates new alert action
	/// - Parameters:
	///   - title: action title
	///   - style: action style
	///   - handler: alert callback
	/// - Returns: new alert action
	public static func action(title: String, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
		UIAlertAction(title: title, style: style, handler: handler)
	}
}

public extension UIAlertController {

	/// present alert on parent scene
	/// - Parameters:
	///   - scene: parent scene
	///   - animated: animation flag
	///   - completion: completion callback
	func present(toParent scene: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
		scene.present(self, animated: animated, completion: completion)
	}
}
