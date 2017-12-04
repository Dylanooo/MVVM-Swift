//
//  HideTopNavBarController.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/7.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class HideTopNavBarController: UINavigationController {

	
	
	var hideTopBarVC: [String]?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		hideTopBarVC = NSArray(contentsOfFile: Bundle.main.path(forResource: "HideNavConfigure", ofType: "plist")!) as? [String]
		navigationBar.isTranslucent = true
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.shadowImage = UIImage()
		navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18.0, weight: .light),
											 NSAttributedStringKey.foregroundColor: UIColor.darkGray]
		delegate = self
		UIApplication.shared.isStatusBarHidden = false
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension HideTopNavBarController: UINavigationControllerDelegate {
	
	func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
		assert(!(viewController is UITableViewController), "此样式下不支持UITableViewController")
		let willShowName = type(of: viewController).debugDescription().components(separatedBy: ".").last
		
		for vc in hideTopBarVC! {
			if let name = willShowName {
				
				if name == vc {
					return
				}
			}
		}
		
		var hasAddBar = false
		for sub in viewController.view.subviews {
			if type(of: sub) == PlaceHolderNavBar.self {
				hasAddBar = true
			}
		}
		
		guard hasAddBar else {
			UIApplication.shared.isStatusBarHidden = false
			UIApplication.shared.statusBarStyle = .default
			var offsetY: CGFloat = 0
			let bar = PlaceHolderNavBar()
			let globalBar = UINavigationBar.appearance()
			bar.barStyle = globalBar.barStyle
			bar.setBackgroundImage(UIImage(color: .white), for: .default)
			bar.shadowImage = UIImage(color: UIColor(hexColor: "#e9e9e9"), size: CGSize(width: kScreenWidth, height: 1/UIScreen.main.scale))
			
			viewController.view.addSubview(bar)

			if viewController is UITableViewController {
				offsetY = -64
				bar.snp.makeConstraints({ make in
					make.left.equalToSuperview()
					make.width.equalToSuperview()
					if isiPhoneX {
						make.top.equalToSuperview().offset(offsetY)
					} else {
						make.top.equalTo(offsetY)
					}
					make.height.equalTo(isiPhoneX ? 122 : 64)
				})
			} else {
				bar.snp.makeConstraints({ make in
					make.left.right.equalToSuperview()
					if isiPhoneX {
						make.top.equalToSuperview().offset(offsetY)
					} else {
						make.top.equalTo(offsetY)
					}
					make.height.equalTo(isiPhoneX ? 122 : 64)
				})
			}
			return
		}
		
	}
	
	func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
		let willShowName = type(of: viewController).debugDescription().components(separatedBy: ".").last
		
		for vc in hideTopBarVC! {
			if let name = willShowName {
				
				if name == vc {
					UIApplication.shared.isStatusBarHidden =  (name == "LoginController")
					UIApplication.shared.statusBarStyle = .lightContent
					return
				}
			}
		}
	}
	
}
