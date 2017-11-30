//
//  NSObjectExt.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/8/1.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

extension NSObject {
	
	convenience init(_ dictionary: [String: Any?]) {
		
		self.init()
		
		for (key, value) in dictionary {
			
			let sucess = setValueOfProperty(property: key, value: value)
			
			if sucess {
				DebugPrint("✅assignment for \(key) sucess.")
			} else {
				DebugPrint("❎assignment for \(key) failed.")
			}
		}
		
	}
	
	/**
	获取对象对于的属性值，无对于的属性则返回nil
	
	- parameter property: 要获取值的属性
	
	- returns: 属性的值
	*/
	func getValueOfProperty(property: String) -> Any? {
		
		let allPropertys = getAllPropertys()
		
		if (allPropertys.contains(property)) {
			
			return value(forKey: property)
			
		} else {
			return nil
		}
	}
	
	/**
	设置对象属性的值
	
	- parameter property: 属性
	- parameter value:    值
	
	- returns: 是否设置成功
	*/
	func setValueOfProperty(property: String, value: Any?) -> Bool {
		
		let allPropertys = getAllPropertys()
		
		if(allPropertys.contains(property)) {
			
			setValue(value, forKey: property)
			
			return true
			
		} else {
			
			return false
			
		}
	}
	
	/**
	获取对象的所有属性名称
	
	- returns: 属性名称数组
	*/
	func getAllPropertys()->[String]{
		
		var result = [String]()
		let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 0)
		let buff = class_copyPropertyList(object_getClass(self), count)
		let countInt = Int(count[0])
		
		for i in 0..<countInt {
			
			let temp = buff?[i]
			
			let tempPro = property_getName(temp!)
			
			let proper = String(validatingUTF8: tempPro)
			
			result.append(proper!)
			
		}
		
		return result
	}
}
