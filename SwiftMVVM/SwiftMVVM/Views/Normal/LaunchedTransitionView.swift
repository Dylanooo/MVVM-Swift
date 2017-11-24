//
//  LaunchedTransitionView.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/10.
//  Copyright © 2017年 Autohome.Inc. All rights reserved.
//

import UIKit

class LaunchedTransitionView: UIView {
	var bgImgView: UIImageView!
	convenience init() {
		self.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
		setupUI()
	}
	
	
	class func show() {
		let launchView = LaunchedTransitionView()
		let window: UIWindow = UIApplication.shared.windows.first ?? UIWindow()
		window.addSubview(launchView)
		launchView.snp.makeConstraints { make in
			make.top.bottom.left.right.equalToSuperview()
		}
		launchView.delayToHide()
	}
	
	func setupUI() {
		bgImgView = UIImageView()
		bgImgView.image = UIImage(named: "IMG_Cool_Car_5")
		addSubview(bgImgView)
		bgImgView.snp.makeConstraints { make in
			make.top.bottom.left.right.equalToSuperview()
		}
		
		let logoImgView = UIImageView()
		logoImgView.image = UIImage(named: "img_login_autohome")
		bgImgView.addSubview(logoImgView)
		logoImgView.snp.makeConstraints { make in
			make.width.equalTo(135)
			make.height.equalTo(57)
			make.top.equalTo(119)
			make.centerX.equalToSuperview()
		}
	}

	func delayToHide() {
		let window: UIWindow = UIApplication.shared.delegate!.window!!
		window.rootViewController!.view.alpha = 1
		UIView.animate(withDuration: 3, animations: {
			self.bgImgView.alpha = 0
		}, completion: { finish in
			self.removeFromSuperview()
		})
	}

}

