//
//  SimpleProgressView.swift
//  Meet & Greet
//
//  Created by Mansoor Ali on 09/08/2020.
//  Copyright © 2020 Fahad Baig. All rights reserved.
//

import UIKit
import Reusable
import Utilities
/// Displays an activity indicator view at the center
final class SimpleProgressView: UIView, NibOwnerLoadable {

	//MARK: Properties
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var bgView: UIView!

	//MARK: Lifecycle
	override init(frame: CGRect) {
		super.init(frame: frame)
		loadNibContent()
		bgView.layer.cornerRadius = 6
		bgView.layer.applySketchShadow(color: .black, alpha: 0.3, blur: 3, spread: 0)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: View Animatable
extension SimpleProgressView: ViewAnimatable {

	var animationDuration: Double { return 0.3 }

	var isAnimating: Bool {
		return activityIndicatorView.isAnimating
	}

	func playAnimation() {
		activityIndicatorView.startAnimating()
	}

	func stopAnimation() {
		activityIndicatorView.stopAnimating()
	}
}


//MARK: ViewDisplayable
extension SimpleProgressView: ViewDisplayable {


	var viewTransitionDuration: Double {
		return 0.3
	}

	/// Add view and display view on another view
	///
	/// - Parameters:
	///   - view: parent view on which view will be displayed
	///   - insets: margins from edges
	///   - animated: with fade animation if true
	///   - completion: callback when view is displayed
	func show(fromView view: UIView, insets: UIEdgeInsets, animated: Bool, completion: ((Bool) -> Void)?) {

		add(to: view, withInsets: insets)
		presentView(animated: animated) { [weak self] (finished) in
			if finished{
				self?.playAnimation()
			}
			completion?(finished)
		}
	}


	/// Hide and remove view from superview
	///
	/// - Parameters:
	///   - animated: with fade animation if true
	///   - completion: callback when view is hidden and removed
	func hide(animated: Bool, completion: ((Bool) -> Void)?) {
		self.stopAnimation()
		self.dismissView(animated: animated, completion: completion)
	}
}
