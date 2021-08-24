//
//  Shakeable.swift
//  Common
//
//  Created by Mansoor Ali on 20/08/2018.
//  Copyright © 2018 Mansoor Ali. All rights reserved.
//
import Foundation
import UIKit

/// A protocol that adds a method `shake()` to a UIView. The default implementation of the method is inherited by just conforming to this protocol.
public protocol Shakeable {}

public extension Shakeable where Self: UIView {
    /// Shakes the view horizontally to draw attention of the user about missing compulsory action.
    ///
    /// - Parameters:
    ///   - duration: The duration for the shake animation in seconds. Optional. Default value is 1.0
    ///   - oscillations: Number of oscillations the view must make before becoming stationary again. Optional. Default value is 4
    ///   - amplitude: Maximum displacement in pt the view can make while shaking. Optional. Default value is 20.0
    ///   - timingFunction: Timing function for the animation. Optional. Default value is `linear`
    func shake(duration:CFTimeInterval = 1.0, oscillations:UInt = 4, amplitude:Float = 20.0, timingFunction:CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)) {
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = timingFunction
        animation.duration = duration
        var values:[Float] = [amplitude, -amplitude]
        for x in 0...4{
            let disp = amplitude / powf(2, Float(x))
            values.append(disp)
            values.append(-disp)
        }
        values.append(0)
        animation.values = values//[-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        self.layer.add(animation, forKey: "shake")
    }
}
