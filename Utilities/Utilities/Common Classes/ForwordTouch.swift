//
//  NationalCommentLayer.swift
//  NationalUIKit
//
//  Created by Mehsam Saeed on 23/06/2020.
//  Copyright © 2020 Incubasys. All rights reserved.
//

import Foundation
import UIKit
class ForwordTouch: UIView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for sb in self.subviews{
            if sb.hitTest(self.convert(point, to: sb), with: event) != nil{
                return true
            }
        }
        return false
    }
}
