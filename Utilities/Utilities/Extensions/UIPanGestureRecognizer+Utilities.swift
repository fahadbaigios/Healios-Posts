//
//  UIPan+Utilities.swift
//  Utilities
//
//  Created by Mansoor Ali on 03/05/2019.
//  Copyright © 2019 Incubasys. All rights reserved.
//

import UIKit

public extension UIPanGestureRecognizer {

	enum Direction {
		case horizontal
		case vertical
	}

	func getPanDirection(velocity: CGPoint) -> Direction {
		var panDirection: Direction = .horizontal
		if ( velocity.x > 0 && velocity.x > abs(velocity.y) || velocity.x < 0 && abs(velocity.x) > abs(velocity.y) ){
			panDirection = .horizontal
		}else if ( velocity.y < 0 && abs(velocity.y) > abs(velocity.x) || velocity.y > 0 &&  velocity.y  > abs(velocity.x)) {
			panDirection = .vertical
		}

		return panDirection
	}
}
