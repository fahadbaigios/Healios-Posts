//
//  CALayer+Utilities.swift
//  Utilities
//
//  Created by Mansoor Ali on 03/05/2019.
//  Copyright © 2019 Incubasys. All rights reserved.
//

import UIKit

public extension CALayer {


	/// Apply shadow providing argumenst same as used in sketch
	///
	/// - Parameters:
	///   - color: shadow color
	///   - alpha: shadow alpha
	///   - x: x offset
	///   - y: y offset
	///   - blur: shadow blurr
	///   - spread: shadow spread
	func applySketchShadow( color: UIColor , alpha: Float, blur: CGFloat, spread: CGFloat, offset: CGSize = .zero) {
		shadowColor = color.cgColor
		shadowOpacity = alpha
		shadowOffset = offset
		shadowRadius = blur / 2.0
		if spread == 0 {
			shadowPath = nil
		} else {
			let dx = -spread
			let rect = bounds.insetBy(dx: dx, dy: dx)
			shadowPath = UIBezierPath(rect: rect).cgPath
		}
	}
}

