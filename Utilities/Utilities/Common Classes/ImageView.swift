//
//  ImageView.swift
//  Utilities
//
//  Created by Mehsam Saeed on 29/10/2020.
//  Copyright © 2020 Fahad Baig. All rights reserved.
//

import UIKit
public class RoundedCornerImageView:UIImageView{
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
                DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {[weak self] in
                    guard let self = self else {return}
                    self.roundCorners(corners: [.bottomLeft,.bottomRight], radius: self.cornerRadiou)
                }
                
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        cornerRadiou = CGFloat(10)
    }
}
