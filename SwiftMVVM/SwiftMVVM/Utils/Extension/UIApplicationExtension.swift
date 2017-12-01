//
//  UIApplicationExtension.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/8.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

extension UIApplication {
	private static let classSwizzedMethod: Void = {
		UIImagePickerController.cm_swizzleMethod
		UINavigationBar.cm_swizzleMethod
		UIViewController.cmp_swizzleMethod
	}()
	
	open override var next: UIResponder? {
		UIApplication.classSwizzedMethod
		return super.next
	}
}
