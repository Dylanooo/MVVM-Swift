//
//  AutoProgressHUD.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/6.
//  Copyright © 2017年 Autohome.Inc. All rights reserved.
//

import UIKit
import MBProgressHUD

class AutoProgressHUD {
	
	class func showAutoHud(_ msg: String) {
		let keyWindow: UIWindow = UIApplication.shared.windows.first!
		let hud = MBProgressHUD(view: keyWindow)
		hud.label.text = msg
		hud.label.textColor = .darkGray
		keyWindow.addSubview(hud)
		hud.show(animated: true)
		hud.hide(animated: true, afterDelay: 2.0)
	}

}
