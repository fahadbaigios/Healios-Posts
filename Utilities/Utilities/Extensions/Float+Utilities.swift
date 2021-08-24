//
//  Float+Utilities.swift
//  Utilities
//
//  Created by Mansoor Ali on 03/05/2019.
//  Copyright © 2019 Incubasys. All rights reserved.
//

import Foundation

public extension Float {
	func rad2deg() -> Float {
		return self * (Float) (180.0 /  Double.pi)
	}

	func deg2rad() -> Float{
		return self * (Float)(Double.pi / 180)
	}
}
