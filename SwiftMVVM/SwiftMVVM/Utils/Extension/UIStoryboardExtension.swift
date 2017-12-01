//
//  UIStoryboardExt.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/6.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

extension UIStoryboard {
	class func vcInMainSB(_ identifier: String, sbName: String = "Main") -> UIViewController {

		let sb = UIStoryboard(name: sbName, bundle: nil)

		return sb.instantiateViewController(withIdentifier: identifier)
	}
}
