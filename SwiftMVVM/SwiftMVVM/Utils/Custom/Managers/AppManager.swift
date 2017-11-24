//
//  AppManager.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/8/14.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

private let singleton = AppManager()

class AppManager {
	
	public class var `default`: AppManager {
		return singleton
	}
	
	var version: String {
		return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
	}
	
	class func setupAppConfigure() {
		ThemeManager.setupMainTheme()
	}

}
