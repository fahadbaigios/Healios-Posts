//
//  UIViewController.swift
//  Utilities
//
//  Created by Mehsam Saeed on 25/09/2019.
//  Copyright © 2019 Incubasys. All rights reserved.
//

import Foundation
import UIKit
public extension UIViewController{
    func share(data:[Any])  {
            let activityViewController = UIActivityViewController(activityItems: data, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
    //        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
        }
}
