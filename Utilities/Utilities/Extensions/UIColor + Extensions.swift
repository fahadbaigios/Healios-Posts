//
//  Color + Extensions.swift
//  Common
//
//  Created by Mansoor Ali on 21/11/2016.
//  Copyright © 2016 Techtix co. All rights reserved.
//
import Foundation
import UIKit

public extension UIColor {
    
    /// An initializer to synthesize a UIColor with exact 0-255 RGB values rather than percentage.
    /// - Requires: All color channel values **MUST** be between 0 and 255
    /// - Parameters:
    ///   - red: Value for Red component
    ///   - green: Value for Green component
    ///   - blue: Value of Blue component
    private convenience init(red: UInt, green: UInt, blue: UInt) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    /// An initializer to synthesize UIColor from Hex Value
    ///
    /// - Parameter netHex: Integer representation of Net Hex value of color to be synthesized
    convenience init(netHex:UInt) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    /// An initializer to synthesize UIColor from Hex representation string and alpha channel value
    ///
    /// - Parameters:
    ///   - hexString: Hex representation of color as a string
    ///   - alpha: Opacity value of the color. should be between 0 and 1.
    convenience init(hexString: String, alpha: CGFloat = 1.0, defaultColor:UIColor = UIColor.black) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var hex: UInt32 = 0
        let scanner: Scanner = Scanner(string: cString)
        if scanner.scanHexInt32(&hex){
            let hexInt = UInt(hex)
            
            let color = UIColor.init(netHex: hexInt)
            self.init(cgColor: color.withAlphaComponent(alpha).cgColor)
        }else{
            self.init(cgColor: defaultColor.withAlphaComponent(alpha).cgColor)
        }
    }
    
    convenience init?(hex:String){
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var hex: UInt32 = 0
        let scanner: Scanner = Scanner(string: cString)
        if scanner.scanHexInt32(&hex){
            let hexInt = UInt(hex)
            
            let color = UIColor.init(netHex: hexInt)
            self.init(cgColor: color.withAlphaComponent(1.0).cgColor)
        }else{
            return nil
        }
    }
    
    /// An array containing value of red, green, blue and alpha compenents of the UIColor. All values are percentage representation of the respective channel.
    var rgba: [CGFloat] {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        if getRed(&r, green: &g, blue: &b, alpha: &a){
            return [r,g,b,a]
        }
        
        return[0,0,0,0]
    }
    
    /** String reprentation of red, green, blue and alpha components of the UIColor. Returns results in the format
     - Note: Values of red, green and blue compenents are exact Integer values between 0-255. Alpha component is fractional representation of opacity between 0 and 1.
     
     Output Format:
     RGBA(<red>,<green>,<blue>,<alpha>)
     
     */
    var rgbaString: String{
        let rgba = self.rgba
        return "RGBA(\(Int(rgba[0]*255)),\(Int(rgba[1]*255)),\(Int(rgba[2]*255)),\(rgba[3])))"
    }
    
    /// Hex Representation of the UIColor as a string.
    var hexString: String {
        
        let rgba = self.rgba
        let rgb:Int = (Int)(rgba[0]*255)<<16 | (Int)(rgba[1]*255)<<8 | (Int)(rgba[2]*255)<<0
        
        return String(format: "#%06x", rgb)
    }

	///return color used in lightMode
	///this color doesn't change automatically for light/dark Mode
	var lightOnly: UIColor {
		if #available(iOS 13.0, *) {
			return self.resolvedColor(with: .init(userInterfaceStyle: .light))
		} else {
			return UIColor.red
		}
	}

	///return color used in darkMode
	///this color doesn't change automatically for light/dark Mode
	var darkOnly: UIColor {
		if #available(iOS 13.0, *) {
			return self.resolvedColor(with: .init(userInterfaceStyle: .dark))
		} else {
			return UIColor.red
		}
	}
    
}
