//
//  ViewAnimatable.swift
//  TUIKit
//
//  Created by Mansoor Ali on 21/01/2019.
//  Copyright © 2019 Mansoor Ali. All rights reserved.
//

import UIKit


/// A type that can be animted
public protocol ViewAnimatable {
	var isAnimating: Bool { get }
	var animationDuration: Double { get }
	func playAnimation()
	func stopAnimation()
}


/// A Type that can be displayed from a view or controller
public protocol ViewDisplayable {
	var viewTransitionDuration: Double { get }
//	func show(fromViewController viewController: UIViewController,
//			  insets: UIEdgeInsets,
//			  animated: Bool,
//			  completion: ((Bool) -> Void)? )

	func show(fromView view: UIView,
			  insets: UIEdgeInsets,
			  animated: Bool,
			  completion: ((Bool) -> Void)? )

	func hide(animated: Bool,
			  completion: ((Bool) -> Void)?)
}

public extension ViewDisplayable where Self: UIView {


	/// Presents View
	///
	/// - Parameters:
	///   - animated: should animate
	///   - completion: callback after view is presented
	func presentView(animated: Bool, completion:((Bool) -> Void)? = nil) {
		self.superview?.bringSubviewToFront(self)
		if animated {
			UIView.animate(withDuration: viewTransitionDuration, animations: { [weak self] in
				self?.alpha = 1
				}, completion: completion)
		}else {
			self.alpha = 1
			completion?(true)
		}
	}

	/// Stop Animation and hides View
	///
	/// - Parameters:
	///   - animated: should animate
	///   - completion: callback after view is dismissed
	func dismissView(animated: Bool, completion: ((Bool) -> Void)?) {
		let closure: (Bool) -> Void  = { (finished) in
			if finished { self.removeFromSuperview() }
		}
		if animated {
			UIView.animate(withDuration: viewTransitionDuration, delay: 0.25, animations: {
				self.alpha = 0
			}) { (finished) in
				closure(finished)
				completion?(finished)
			}
		}else {
			self.alpha = 0
			closure(true)
			completion?(true)
		}
	}


	/// Add calling View to parent
	///
	/// - Parameters:
	///   - parent: parent on which calling view is diplayed
	///   - insets: view margins
    func add(to parent: UIView, withInsets insets: UIEdgeInsets)  {

        let child = self

        parent.addSubview(child)


        child.alpha = 0
		child.superview?.sendSubviewToBack(child)

		//Autolayout constraints
		child.translatesAutoresizingMaskIntoConstraints = false
		child.topAnchor.constraint(equalTo: parent.topAnchor, constant: insets.top).isActive = true
		parent.bottomAnchor.constraint(equalTo: child.bottomAnchor, constant: insets.bottom).isActive = true
		child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: insets.left).isActive = true
		parent.trailingAnchor.constraint(equalTo: child.trailingAnchor, constant: insets.right).isActive = true
	}
}



/// A Type which has retry option
public protocol ViewReloadable {
	typealias ActionCallBack = ((_ error: ViewDisplayable, _ sender: UIButton) -> Void)
	var actionCallback: ActionCallBack? { get set }
}


/// A type that can be displayed on view or view controller, can animated and has retry option.
///
/// `ViewErrorDisplayable` is a type alias for the `ViewAnimatable`, `ViewDisplayable` and `ViewReloadable` protocols.
/// When you use `Codable` as a type or a generic constraint, it matches
/// any type that conforms to these three protocols.
public typealias ViewErrorDisplayable =  ViewDisplayable & ViewReloadable
