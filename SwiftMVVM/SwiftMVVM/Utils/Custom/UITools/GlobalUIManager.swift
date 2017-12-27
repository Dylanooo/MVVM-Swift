//
//  GlobalUIManager.swift
//  SwiftMVVM
//
//  Created by Dylan.Lee on 13/12/2017.
//  Copyright © 2017 Dylan.Lee. All rights reserved.
//

import UIKit

class GlobalUIManager {
    class func loadHomeVC() {
        let kWindow: UIWindow = UIApplication.shared.keyWindow!
        let rootVC = UIStoryboard.vcInMainSB("MainTabBarController")
        rootVC.modalTransitionStyle = .crossDissolve
        UIView.transition(with: kWindow,
                          duration: 1,
                          options: .transitionCrossDissolve,
                          animations: {
                            let oldState = UIView.areAnimationsEnabled
                            UIView.setAnimationsEnabled(false)
                            kWindow.rootViewController = rootVC
                            kWindow.makeKeyAndVisible()
                            UIView.setAnimationsEnabled(oldState)
                            
        }, completion: nil)
    }
    
    class func loadLoginVC() {
        
        let kWindow: UIWindow = UIApplication.shared.keyWindow!
        let rootVC = UIStoryboard.vcInMainSB("LoginRootViewController")
        rootVC.view.alpha = 1
        rootVC.modalTransitionStyle = .crossDissolve
        UIView.transition(with: kWindow,
                          duration: 1,
                          options: .transitionCrossDissolve,
                          animations: {
                            let oldState = UIView.areAnimationsEnabled
                            UIView.setAnimationsEnabled(false)
                            kWindow.rootViewController = rootVC
                            kWindow.makeKeyAndVisible()
                            UIView.setAnimationsEnabled(oldState)
    })
    }
}
