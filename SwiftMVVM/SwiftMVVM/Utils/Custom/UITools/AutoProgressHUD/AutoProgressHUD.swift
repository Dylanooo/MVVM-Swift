//
//  AutoProgressHUD.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/6.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import MBProgressHUD

class AutoProgressHUD {
	
	static var hud: MBProgressHUD = {
		let keyWindow: UIWindow = UIApplication.shared.windows.first!
		let hud = MBProgressHUD(view: keyWindow)
		keyWindow.addSubview(hud)
		return hud
	}()
	
	class func showAutoHud(_ msg: String) {
        DispatchQueue.main.async {
            hud.label.text = msg
            hud.mode = .text
            hud.label.textColor = .darkGray
            hud.superview?.bringSubview(toFront: hud)
            hud.show(animated: true)
            hud.hide(animated: true, afterDelay: 2.0)
        }
	}
    
    class func showHud(_ msg: String) {
        DispatchQueue.main.async {
            hud.label.text = msg
            hud.mode = .indeterminate
            hud.label.textColor = .darkGray
            hud.superview?.bringSubview(toFront: hud)
            hud.show(animated: true)
        }
    }
    
    class func hideHud() {
        DispatchQueue.main.async {
            hud.hide(animated: true)
        }
    }

}
