//
//  NSUserDefaults.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/8/1.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

extension UserDefaults {
	
	class func setDefault(key: String, value: Any?) {
		
		if value == nil {
			
			UserDefaults.standard.removeObject(forKey: key)
			
		} else {
			
			UserDefaults.standard.set(value, forKey: key)
			
			UserDefaults.standard.synchronize() //同步
			
		}
	}
	
	class func removeUserDefault(key: String?) {
		
		if key != nil {
			
			UserDefaults.standard.removeObject(forKey: key!)
			
			UserDefaults.standard.synchronize()
			
		}
	}
	
	class func getDefault(key: String) -> Any? {
		
		return UserDefaults.standard.value(forKey: key)
		
	}
}
