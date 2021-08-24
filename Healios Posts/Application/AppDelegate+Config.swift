//
//  AppDelegate.swift
//  Template
//
//  Created by Fahad Baig on 27/12/2018.
//  Copyright © 2018 Fahad Baig. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Store

extension AppDelegate {

    func configureApp(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        overrideSystemFont()
        configureNetworkManager()
        /*configurePayment()
        configureSocial(application: application, launchOptions: launchOptions)
        configureFirebase(application: application)*/
    }


    /// setup network manager
    private func configureNetworkManager() {
		NetworkManager.shared.configure(baseURL: Config.baseURL, apiKey: "")
    }

    private func overrideSystemFont() {
//        let customFont = UIFont.CustomFont(regular: "SofiaProRegular", medium: "SofiaPro-Medium", semibold: "SofiaProSemiBold", bold: "SofiaProBold")
//        UIFont.overrideDefaultTypography(customFont: customFont)
    }

//    private func configureUI() {
//
//        //integrating DroopDown menue
//        DropDown.startListeningToKeyboard()
//
//        //IQKaymanger startuop
//        IQKeyboardManager.shared.enable = true
//    }

    private func configureMap() {

    }
    
}


