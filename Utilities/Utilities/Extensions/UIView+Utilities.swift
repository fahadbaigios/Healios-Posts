//
//  UIView+extensions.swift
//  Common
//
//  Created by Taimour Tanveer on 12/12/2018.
//  Copyright © 2018 Techtix co. All rights reserved.
//

import Foundation
import UIKit

///An Enumerator to enable selection of edge to place border. This purpose of this enumerator is to simplify usage of addBorder extension on UIView
public enum BorderPosition{
    case Top
    case Bottom
    case Left
    case Right
}

public extension UIView{

	/// true when app is running in Dark Mode
	var isDarkMode: Bool { self.traitCollection.userInterfaceStyle == .dark }

	func addBorder(color: UIColor = .red, width: CGFloat = 1, cornerRadius: CGFloat = 0) {
		self.layer.borderColor = color.cgColor
		self.layer.borderWidth = width
		self.layer.cornerRadius = cornerRadius
	}
    /**
     This method adds a conveience method to any UIView to simplify addition of selective border around the view. It can be used with any UIView subtype. This method uses Autolayout to add the border
     - Parameter borderColor: UIColor used to draw the specified border.
     - Parameter borderWidth: Pointsize to be used while drawing the border.
     - Parameter borderPositions: An array that specifies the edges on which the specified border must be added.
     
     - Note: To add border with different width or color on different edges, call the method separately for every width and color combination.
     */
	func addBorder (borderColor:UIColor, borderWidth:Float, borderPositions:[BorderPosition]){
        for position in borderPositions{
            let lineView = UIView()
            lineView.backgroundColor = borderColor
            lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
            self.addSubview(lineView)
            
            let metrics = ["width" : NSNumber(value: borderWidth)]
            let views = ["lineView" : lineView]
            switch position{
                case .Top:
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            case .Bottom:
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            case .Left:
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            case .Right:
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
                self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            }
            
        }
    }
    /**
     Convenience method to add a backgorund image to any UIView object or subclass object.
     
     - Important: This method adds an imageview to the back of the UIView. To remove the background image use
     ````
     view.subviews[0].removeFromSuperview()
     ````
     If this method is called more than once with different opaque images without removing the previous background, only the first image that was applied to background will be visible
     - Parameter image: Image to apply on the background
     - Parameter contentScaleMode: Content mode used to scale the image for cases where the size of the image is not exactly same as the size of the UIView on which the background is being applied. Default content mode is **Center**
     */
	func addBackgroundImage(_ image:UIImage, contentScaleMode:UIView.ContentMode = UIView.ContentMode.center){
        let bgImageView = UIImageView.init(frame: self.bounds)
        bgImageView.contentMode = contentScaleMode
        bgImageView.image = image
        
        
        self.addSubview(bgImageView)
        self.sendSubviewToBack(bgImageView)
    }
    /**
     A convenience method to set the anchor point of a UIView. This method changes the anchor point and applies appropriate transform to avoid changing the position of the view after change of anchor point.
     - Important: Default OS provided method to change anchor point takes anchor point as a percentage of the view size. However, this method expects anchor point to be provided as an exact position from the view origin.
     - Parameter point: The exact point on the view to be set as the new anchor point
     */
	func setAnchorPoint(_ point: CGPoint) {
        ///Calculating new anchor point in terms of percentage of width and height of the view
        let newAnchorPoint = CGPoint(x: point.x/bounds.size.width, y: point.y/bounds.size.height)
        ///New anchor point as exact position on the view. Currently this is exactly the same as the supplied point but is set as a different entity to allow changing the implementation of the method without changing the operation code
        var newPoint = CGPoint(x: bounds.size.width * newAnchorPoint.x, y: bounds.size.height * newAnchorPoint.y)
        ///Old anchor point of the view as exact position on view (rather than percentage)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);
        
        //Applying existing transform on both old and new anchor points to calculate the translation to be applied to avoid changing view translation/scale/rotation after changing the anchor point.
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        //Original position of the view main layer.
        var position = layer.position
        
        //Adjusting the x position according to new anchor point
        position.x -= oldPoint.x
        position.x += newPoint.x

        //Adjusting the y position according to new anchor point
        position.y -= oldPoint.y
        position.y += newPoint.y

        //Setting the properly calculated new position and anchor point
        layer.position = position
        layer.anchorPoint = newAnchorPoint
    }
    /**
     Convenience method to round selected corners of a view. By default all corners of the view are rounded when layer.corner radius is set. However, this method only rounds the specified corners.
     - Important: Calling this method again on the same view will override the effect of the previous call. Therefore this method cannot be used to apply different corner radius on each corner. To add a different radius to different corners use the following method:
     ````
     view.addRoundnessToCorners(corners: UIRectCorner, radius:CGFloat)
     ````
     - Note: This method applies a circular radius and cannot be used to apply an elliptical radius.
     - Parameter corners: Corner on which the radius is expected to be applied. Multiple corners can be provided by using '**|**'. e.g: *.topLeft | .topRight*
     - Parameter radius: Radius of the corner circle.
     */
	func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    /**
     Convenience method to add roundness to selected corners of a view. This method only rounds the specified corners.
     - Important: Calling this method again on the same view will **not** override the effect of the previous call. If a corner is already rounded then the higher of the two radii will be used for that corner. To override the effect of previously rounded corners use the following method:
     ````
     view.roundCorners(corners: UIRectCorner, radius: CGFloat)
     ````
     - Note: This method applies a circular radius and cannot be used to apply an elliptical radius.
     - Parameter corners: Corner on which the radius is expected to be added. Multiple corners can be provided by using '**|**'. e.g: *.topLeft | .topRight*
     - Parameter radius: Radius of the corner circle.
     */
	func addRoundnessToCorners(corners: UIRectCorner, radius: CGFloat) {
        ///UIBezierPath according to the selected corners and radius
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        ///ShapeLayer according the the path
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        ///The original mask of the layer if already set
        if let originalMask = layer.mask{
            //Adding existing mask to the mask layer.
            mask.mask = originalMask
        }
        //Applying the new mask
        layer.mask = mask
    }
    
    /// Drops shadow from a view
    ///
    /// - Parameters:
    ///   - color: Color of the shadow to be drawn
    ///   - opacity: Opacity of the shadow to be drawn. Optional. Default value is 0.5
    ///   - offSet: Offset of the shadow from View's layer.
    ///   - radius: Blur Radius of the Shadow to be dropped. Optional. Default value is 1.0
    ///   - scale: Boolean to enable/disable scaling of the shadow according to UIScreen scale. Optional. Default value is true
	func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        // to avoid blurred content if scale is true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

	func tapAnimation(fadeInDuration: Double = 0.05, fadeOutDuration: Double = 0.3) {
		UIView.animate(withDuration: fadeInDuration, animations: { [weak self] in
			guard let self = self else { return }
			self.alpha = 0.5
		}) { (_) in
			UIView.animate(withDuration: fadeOutDuration, animations: { [weak self] in
				guard let self = self else { return }
				self.alpha = 1.0
			})
		}
	}

	
	/// Adds a subView with constaints
	///
	/// - Parameters:
	///   - child: subview to be added
	///   - insets: view insets
	func add(subView child: UIView, insets: UIEdgeInsets) {
		let parent = self

		child.translatesAutoresizingMaskIntoConstraints = false
		parent.addSubview(child)

		NSLayoutConstraint.activate([
			child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: insets.left),
			child.topAnchor.constraint(equalTo: parent.topAnchor, constant: insets.top),
			parent.trailingAnchor.constraint(equalTo: child.trailingAnchor, constant: insets.right),
			parent.bottomAnchor.constraint(equalTo: child.bottomAnchor, constant: insets.bottom),
			])
	}
}

//MARK: ViewController
public extension UIView {

	var firstAvailableUIViewController: UIViewController? {
		return traverseResponderChainForUIViewController(responder: self.next)
	}
	private func traverseResponderChainForUIViewController(responder: UIResponder?) -> UIViewController? {
		if let vc = responder as? UIViewController {
			return vc
		}else if let v = responder as? UIView {
			return traverseResponderChainForUIViewController(responder: v.next)
		}else {
			return nil
		}
	}
}
//MARK: Drawing

public extension UIView {

	/// Apply mask of specified path to the view
	///
	/// - Parameters:
	///   - path: path/shape of mask
	///   - lineWidth: line width
	///   - borderColor: border color
	///   - fillColor: not actual color but is used as alpha by mask where white = 1 and black  = 0
	func applyMask(path: UIBezierPath, lineWidth: CGFloat, fillColor: UIColor)  {

		let view = self
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		mask.lineWidth = lineWidth
		mask.strokeColor = UIColor.clear.cgColor
		mask.fillColor = fillColor.cgColor
		view.layer.mask = mask
	}


	/// Simply adds a shape layer of specified path to view
	///
	/// - Parameter path: path of to be drawn
	func drawBorder(path: UIBezierPath, lineWidth: CGFloat, borderColor: UIColor, fillColor: UIColor = .clear, cornerRadius: CGFloat = 17) {
		let border = CAShapeLayer()
		border.cornerRadius = cornerRadius
		border.path = path.cgPath
		border.lineWidth = lineWidth
		border.strokeColor = borderColor.cgColor
		border.fillColor = fillColor.cgColor
		self.layer.addSublayer(border)
	}

	
	/// Simply adds a shadow layer of specified path to to superView
	///
	/// - Parameter path: path of to be drawn
	func drawShadow(shadowPath path: UIBezierPath, opacity: Float, radius: CGFloat, color: UIColor, offset: CGSize)  {

		let shadowLayer = CAShapeLayer()
		shadowLayer.path = path.cgPath
		shadowLayer.frame = self.frame

		shadowLayer.shadowOpacity = opacity
		shadowLayer.shadowRadius = radius
		shadowLayer.shadowColor = color.cgColor
		shadowLayer.shadowOffset = offset

		self.superview?.layer.insertSublayer(shadowLayer, below: self.layer)
	}


	func asImage() -> UIImage {
		let renderer = UIGraphicsImageRenderer(bounds: bounds)
		return renderer.image { [weak self]  rendererContext in
			self?.layer.render(in: rendererContext.cgContext)
		}
	}
    
    func asImageWith3dScenes(size: CGSize? = nil, rect: CGRect? = nil) -> UIImage {
        let r: CGRect = (rect != nil) ? rect! : self.bounds
        let s: CGSize = (size != nil) ? size! : self.bounds.size
        let renderer = UIGraphicsImageRenderer(size: s)
        let image = renderer.image { [weak self] (ctx) in
            self?.drawHierarchy(in: r ,afterScreenUpdates: true)
        }
        return image
    }
}

extension UIView {

	func applyShadow(cornerRadius: CGFloat) {
		self.layer.cornerRadius = cornerRadius
		self.layer.applySketchShadow(color: UIColor.init(hex: "000000")!, alpha: 0.3, blur: 10, spread: 0)
	}

	func applyCornerRadius(radius: CGFloat, corners: CACornerMask) {
		self.layer.cornerRadius = radius
		self.layer.masksToBounds = true
		self.layer.maskedCorners = corners
	}
}
