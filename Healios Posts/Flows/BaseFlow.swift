//
//  BaseFlow.swift
//  BBMerchant
//
//  Created by Fahad Baig on 02/02/2020.
//  Copyright © 2020 Techtix. All rights reserved.
//

import RxFlow
import Utilities

class BaseFlow: NSObject, Flow {
    var root: Presentable {
        return UIViewController()
    }
    
    func navigate(to step: Step) -> FlowContributors {
        if let step = step as? AppStep{
            return navigateToAppStep(step: step)
        }else {
            return .none
        }
    }
    
    func navigateToAppStep(step: AppStep) -> FlowContributors {
        return .none
    }
}

extension ViewModel where Self: Stepper {
    func trigger(step: AppStep) {
        self.steps.accept(step)
    }
}
