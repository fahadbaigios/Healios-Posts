//
//  File.swift
//  Utilities
//
//  Created by Mansoor Ali on 25/02/2019.
//  Copyright © 2019 Incubasys. All rights reserved.
//

import UIKit

public extension UITableViewCell {

	func hideDefaultSeparator()  {
		self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
	}
}
