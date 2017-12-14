//
//  AppDelegate.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/25.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import AVFoundation
import WebKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		window = UIWindow()
		window?.makeKeyAndVisible()
		AppManager.setupAppConfigure()
		setupRootWindow()
		LaunchedTransitionView.show()
		
		return true
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
	}

	func applicationWillTerminate(_ application: UIApplication) {
		DebugPrint("杀死进程~~~~~~~~~")
	}
	
	/// Custom methods
	func setupRootWindow() {
        
        
        /// 根据用户登录状态加载
        let db = DataBaseManager.default
        let user = db.queryObjects(type: User.self).first
        
        if let _ = user {
            
            GlobalUIManager.loadHomeVC()
            
        } else {
            
            let loginVC = UIStoryboard.vcInMainSB("LoginRootViewController")
            loginVC.view.alpha = 0
            window?.rootViewController = loginVC
            
        }
		
	}

}

