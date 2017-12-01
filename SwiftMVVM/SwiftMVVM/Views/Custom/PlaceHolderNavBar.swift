//
//  HiddenTopNavBar.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/7.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class PlaceHolderNavBar: UINavigationBar {

	override func layoutSubviews() {
		super.layoutSubviews()
		
		for sub in subviews {
			
			let className = type(of: sub).description().components(separatedBy: ".").last ?? ""
			
			if className == "_UINavigationBarContentView" {
				
				sub.frame = CGRect(x: 0, y: 0, width: sub.width, height: isiPhoneX ? 88 : 64)
				
			} else if className == "_UIBarBackground" {
				
				sub.frame = CGRect(x: 0, y: 0, width: sub.width, height: isiPhoneX ? 88 : 64)
				
			}
			
		}
	}
}
