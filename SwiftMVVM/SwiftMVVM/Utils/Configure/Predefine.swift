//
//  Predefine.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/31.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

public let kWindow: UIWindow? = UIApplication.shared.windows.last

let appdelegate = UIApplication.shared.delegate as! AppDelegate

let kScreenWidth = UIScreen.main.bounds.width

let kScreenHeight = UIScreen.main.bounds.height

let isiPhoneX = ((UIScreen.main.bounds.height - 812) == 0 ? true : false)

public func DebugPrint(_ item: Any) {
	
	#if DEBUG && FOO
		
		print(item)
		
	#endif
}
