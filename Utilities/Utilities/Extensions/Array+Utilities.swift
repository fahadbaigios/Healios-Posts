//
//  String+custom.swift
//  TCommons
//
//  Created by Mansoor Ali on 21/01/2019.
//  Copyright © 2019 Mansoor Ali. All rights reserved.
//

import Foundation

public extension Array {

	func getValue(atIndex index: Int) -> Element? {
		guard index < self.count else { return nil}
		return self[index]
	}
}
