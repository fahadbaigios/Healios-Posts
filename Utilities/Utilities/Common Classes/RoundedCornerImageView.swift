//
//  RoundedCornerImageView.swift
//  Utilities
//
//  Created by Mehsam Saeed on 02/11/2020.
//  Copyright © 2020 Fahad Baig. All rights reserved.
//

import UIKit
open class RoundedCornerImageView: UIView {
    @IBInspectable var cornerRadiou:CGFloat = 10
    
    @IBInspectable var circleFromTop :Bool = true{
        didSet{
            if circleFromTop{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {[weak self] in
                    guard let self = self else {return}
                    self.roundCorners(corners: [.topLeft,.topRight], radius: self.cornerRadiou)
                }
            }
        }
    }
    
    @IBInspectable var circleFromBottom :Bool = false{
        didSet{
            if circleFromBottom{
                self.roundCorners(corners: [.bottomLeft,.bottomRight], radius: cornerRadiou)
                
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        cornerRadiou = CGFloat(10)
    }
}
