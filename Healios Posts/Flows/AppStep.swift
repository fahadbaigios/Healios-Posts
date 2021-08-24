//
//  AppStep.swift
//  BBMerchant
//
//  Created by Fahad Baig on 02/02/2020.
//  Copyright © 2020 Techtix. All rights reserved.
//


import RxFlow
import Store

public enum AppStep: Step {
    case posts
	case postDetail(PostMO)
}

