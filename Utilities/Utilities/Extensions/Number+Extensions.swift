//
//  Number+Extensions.swift
//  Utilities
//
//  Created by Mehsam Saeed on 22/10/2020.
//  Copyright © 2020 Fahad Baig. All rights reserved.
//

import Foundation
import UIKit
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    func toString() -> String {
        return ("\(self)")
    }
}

public extension CGFloat {
    /// Rounds the CGFloat to decimal places value
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
    func toString() -> String {
        return ("\(self)")
    }
}
