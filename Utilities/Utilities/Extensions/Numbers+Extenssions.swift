//
//  Numbers+Extenssions.swift
//  Utilities
//
//  Created by Mehsam Saeed on 22/10/2020.
//  Copyright © 2020 Fahad Baig. All rights reserved.
//

import Foundation
import UIKit
public extension Double {
    /// Round Double Value
    /// - Parameter places: number of places after point
    /// - Returns: Double
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    func toString() -> String {
        return "\(self)"
    }
}

public extension CGFloat {
    /// Round CGFloat Value
    /// - Parameter places: number of places after point
    /// - Returns: CGFloat
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toString() -> String {
        return "\(self)"
    }
}
