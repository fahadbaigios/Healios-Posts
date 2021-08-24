//
//  UIImage + Extensions.swift
//  Common
//
//  Created by Taimour Tanveer on 24/12/2018.
//  Copyright © 2018 Techtix co. All rights reserved.
//

import Foundation
import UIKit

public extension CIImage {
    
    /// Computed poperty to be used to convert CIImage to UIImage
    var image: UIImage? {
        let image = UIImage(ciImage: self)
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        defer { UIGraphicsEndImageContext() }
        image.draw(in: CGRect(origin: .zero, size: image.size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
public extension UIImage {

    /// Convenience method to saturation applied UIImage from a UIImage
    ///
    /// - Parameter value: The value of saturation to be applied on the image. Should be between 0 and 1
    /// - Returns: A copy of the original image with saturation applied
    func applying(saturation value: NSNumber) -> UIImage? {
        return CIImage(image: self)?
            .applyingFilter("CIColorControls", parameters: [kCIInputSaturationKey: value])
            .image
    }
    /// Computed property to get grayscale copy of a UIImage object. Returns a copy of the UIImage with 0 saturation.
    var grayscale: UIImage? {
        return applying(saturation: 0)
    }
    
    /**
     A convenience method to build an image synthesized by making a gradient using the colors supplied in the colors array.
     - Parameter size: The size of the output image. Optional.  Default value is width: 100, height: 100.
     - Parameter colors: An array of colors to be used to synthesize the gradient.
     - Note: The size of the image returned is 100*100 when the
     */
    static func imageWithGradient(size:CGSize = CGSize(width: 100, height: 100), colors:[CGColor]) -> UIImage{
        let gradient = CAGradientLayer.init()
        gradient.colors = colors
        gradient.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        
        UIGraphicsBeginImageContext(gradient.bounds.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image ?? UIImage()
    }
}
//
//  UIImage+custom.swift
//  Basic
//
//  Created by Mansoor Ali on 15/08/2018.
//  Copyright © 2018 Mansoor Ali. All rights reserved.
//

//MARK: Custom Initializer
public extension UIImage {
    
    static func imageFromColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0,y: 0,width: size.width,height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
    
    func withTint(_ tint: UIColor) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        tint.setFill()
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x:0,y:self.size.height)
        context.scaleBy(x:1.0,y:-1.0)
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0,y: 0,width: self.size.width,height: self.size.height)
        context.clip(to:rect,mask:self.cgImage!)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

//MARK:- Rounded Image
public extension UIImage{
    
    /// A convenience method to get a copy of UIImage with corners rounded
    ///
    /// - Parameter radius: Radius of the corners of the synthesized image. Optional. Default value is 25% of the size of the image
    /// - Returns: Rounded copy of the image
    func roundedCopy(withCornerRadius radius:CGFloat = 0) -> UIImage? {
        let cornerRadius = (radius == 0) ? min(size.height/4, size.width/4) : radius
        
        let imageView = UIImageView(image: self)
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in:context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    /// A copy of the image with circular mask applied
    var circularCopy: UIImage? {
        let minDimension = min(size.width, size.height)
        let square = CGSize(width: minDimension, height: minDimension)
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in:context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

//MARK:- Scaling
public extension UIImage{
    
    /// A convenience method to apply scaling on the image by a scaling factor.
    ///
    /// - Parameter factor: The factor by which the image is ro be scaled. E.g. a factor value of 2.0 returns an image double in size and height of the original image.
    /// - Returns: Scaled copy of the image
    func scaledByFactor(_ factor:CGFloat) -> UIImage{
        let newWidth = self.size.width * factor
        let newHeight = self.size.height * factor
        let newSize = CGSize(width: newWidth, height: newHeight)
        return UIImage.scaleImage(image: self, size: newSize)
    }
    
    /// A convenience method to scale the image to a particular width while maintaining the original aspect ratio
    ///
    /// - Parameter width: Target width of the image
    /// - Returns: Scaled copy of the image
    func scaledToWidth(_ width:CGFloat) -> UIImage{
        let ratio = self.size.width / self.size.height
        let newHeight = width / ratio
        let size = CGSize(width: width, height: newHeight)
        return UIImage.scaleImage(image:self, size: size)
    }
    
    /// A convenience method to scale the image to a particular height while maintaining the original aspect ratio
    ///
    /// - Parameter height: Target height of the image
    /// - Returns: Scaled copy of the image
    func scaledToHeight(_ height:CGFloat) -> UIImage{
        let ratio = self.size.width / self.size.height
        let newWidth = height * ratio
        let size = CGSize(width: newWidth, height: height)
        return UIImage.scaleImage(image:self, size: size)
    }
    
    private class func scaleImage(image:UIImage,size:CGSize)->UIImage{
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x:0,y: 0, width: size.width,height: size.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in:rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

//MARK:- Encoding
public extension UIImage{
    
    /// Returns base 64 String representation of the UIImage
    var base64EncodedString: String? {
        let data = self.pngData()
        if let base64String = data?.base64EncodedString(options: .lineLength64Characters) {
            return base64String
        }
        return nil
    }
}
