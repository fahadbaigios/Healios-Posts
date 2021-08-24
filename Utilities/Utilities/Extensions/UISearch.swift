//
//  UISearch.swift
//  Utilities
//
//  Created by Mehsam Saeed on 30/09/2020.
//  Copyright © 2020 Fahad Baig. All rights reserved.
//

import Foundation
import UIKit
public extension UISearchBar {
    /// Get Text Field From Search Bar
   var textField: UITextField? {

   func findInView(_ view: UIView) -> UITextField? {
       for subview in view.subviews {
           if let textField = subview as? UITextField {
               return textField
           }
           else if let v = findInView(subview) {
               return v
           }
       }
       return nil
     }

     return findInView(self)
   }
    
    /// Set color of search icon showing on left side of search
    /// - Parameter color: color of search icon
    func setSearchIcon(color: UIColor){
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = color
    }
    
    /// Set custom image of search icone
    /// - Parameter image: custom image to show
    func setSearchIcon(image: UIImage){
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = image
    }
    
    /// Set Custom color of clear button on search bar
    /// - Parameter color: color to set
   func setClearButtonColorTo(color: UIColor){
       let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
       let crossIconView = textFieldInsideSearchBar?.value(forKey: "clearButton") as? UIButton
       crossIconView?.setImage(crossIconView?.currentImage?.withRenderingMode(.alwaysTemplate), for: .normal)
       crossIconView?.tintColor = color
   }
    
    /// Set Custom place holder Color
    /// - Parameter color: color to set
   func setPlaceholderTextColorTo(color: UIColor){
       let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
       textFieldInsideSearchBar?.textColor = color
       let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
       textFieldInsideSearchBarLabel?.textColor = color
   }
}
