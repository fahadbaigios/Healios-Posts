//
//  ConstomImageView.swift
//  NationalUIKit
//
//  Created by Fahad Baig on 25/09/2019.
//  Copyright © 2019 Incubasys. All rights reserved.
//

import Foundation
import UIKit
 public class CustomizedView: UIView {
     @IBInspectable public var cornerRadius: CGFloat = 10{
        didSet{
             configureCornerRadious(radious: cornerRadius)
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 3{
        didSet{
            configureborderWidth(radious: borderWidth)
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear{
        didSet{
             configureBorderColor(color: borderColor)
        }
    }
    @IBInspectable public var drawShadow: Bool = false{
        didSet{
            guard drawShadow else {return}
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {[weak self] in
                guard let self = self else {return}
                self.applyShadow(color: self.shadowColor,shadowAlpha: self.shadowAlpha)
            }
        }
    }
    @IBInspectable public var shadowColor: UIColor = UIColor.clear{
        didSet{
            guard drawShadow else {return}
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {[weak self] in
                guard let self = self else {return}
                self.applyShadow(color: self.shadowColor,shadowAlpha: self.shadowAlpha)
            }
        }
    }
    @IBInspectable public var shadowAlpha: Float = 10
    
    override public func awakeFromNib() {
        configureUI()
    }
    
    private func configureUI(){
        configureCornerRadious(radious: cornerRadius)
        configureBorderColor(color: borderColor)
        configureborderWidth(radious: borderWidth)
    }
    private func configureCornerRadious(radious:CGFloat){
         self.layer.cornerRadius = cornerRadius
    }
    private func configureborderWidth(radious:CGFloat){
          self.layer.borderWidth = borderWidth
    }
    private func configureBorderColor(color:UIColor){
        self.layer.borderColor = borderColor.cgColor
    }
    
    private func applyShadow(color:UIColor,shadowAlpha:Float){
        self.layer.applySketchShadow(color: color, alpha: shadowAlpha, blur: 10, spread: 0)
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configureBorderColor(color: borderColor)
    }
    
}

open class RoundedCornerView: UIView {
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
open class RoundedCornerImageView: UIImageView {
    @IBInspectable public var cornerRadius: CGFloat = 10{
       didSet{
            configureCornerRadious(radious: cornerRadius)
       }
   }
   
   @IBInspectable public var borderWidth: CGFloat = 3{
       didSet{
           configureborderWidth(radious: borderWidth)
       }
   }
   
   @IBInspectable public var borderColor: UIColor = UIColor.clear{
       didSet{
            configureBorderColor(color: borderColor)
       }
   }
   @IBInspectable public var drawShadow: Bool = false{
       didSet{
           guard drawShadow else {return}
           
           DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {[weak self] in
               guard let self = self else {return}
               self.applyShadow(color: self.shadowColor,shadowAlpha: self.shadowAlpha)
           }
       }
   }
   @IBInspectable public var shadowColor: UIColor = UIColor.clear{
       didSet{
           guard drawShadow else {return}
           
           DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {[weak self] in
               guard let self = self else {return}
               self.applyShadow(color: self.shadowColor,shadowAlpha: self.shadowAlpha)
           }
       }
   }
   @IBInspectable public var shadowAlpha: Float = 10
   
   override public func awakeFromNib() {
       configureUI()
   }
   
   private func configureUI(){
       configureCornerRadious(radious: cornerRadius)
       configureBorderColor(color: borderColor)
       configureborderWidth(radious: borderWidth)
   }
   private func configureCornerRadious(radious:CGFloat){
        self.layer.cornerRadius = cornerRadius
   }
   private func configureborderWidth(radious:CGFloat){
         self.layer.borderWidth = borderWidth
   }
   private func configureBorderColor(color:UIColor){
       self.layer.borderColor = borderColor.cgColor
   }
   
   private func applyShadow(color:UIColor,shadowAlpha:Float){
       self.layer.applySketchShadow(color: color, alpha: shadowAlpha, blur: 10, spread: 0)
   }
   
   open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       super.traitCollectionDidChange(previousTraitCollection)
       configureBorderColor(color: borderColor)
   }
   
}


open class PrimaryImageView: UIImageView {
    @IBInspectable var cornerRadius:CGFloat = 10
    
    @IBInspectable var circleFromTop :Bool = true{
        didSet{
            if circleFromTop{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {[weak self] in
                    guard let self = self else {return}
                    self.roundCorners(corners: [.topLeft,.topRight], radius: self.cornerRadius)
                }
            }
        }
    }
    
    @IBInspectable var circleFromBottom :Bool = false{
        didSet{
            if circleFromBottom{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {[weak self] in
                    guard let self = self else {return}
                    self.roundCorners(corners: [.bottomLeft,.bottomRight], radius: self.cornerRadius)
                }
                
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        cornerRadius = CGFloat(10)
    }
    
}
