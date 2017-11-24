//
//  NotifcationCenterExt.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/31.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

extension NotificationCenter {
	
	class func post(name: NotificationNameSpace, object: Any? , userInfo: [AnyHashable : Any]?) {
		
		NotificationCenter.default.post(name: NSNotification.Name(rawValue: name.rawValue),
		                                object: object,
		                                userInfo: userInfo)
		
	}
	
}


enum NotificationNameSpace: String {
	case UIApplicationDidReceiveRemoteNotification
	case UIApplicationDidReceiveLocalNotification
	
}
