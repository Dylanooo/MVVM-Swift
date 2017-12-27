//
//  MainTabBarController.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/2.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
		
        super.viewDidLoad()
		
		self.delegate = self
		
		let tabBar = AHTabBar(frame: self.tabBar.bounds)
		
		tabBar.centerBtnClickedClosure = { [unowned self] in
			
			self.showPopVC()
			
		}
		
		self.setValue(tabBar, forKey: "tabBar")
		
		UIApplication.shared.isStatusBarHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
	
	override var prefersStatusBarHidden: Bool {
		return true
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
}

extension MainTabBarController: UITabBarControllerDelegate {
	
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		
		if viewController is PlaceHolderViewController {
			
			showPopVC()
			
		}
		
		return !(viewController is PlaceHolderViewController)
	}
	
	func showPopVC() {
		
		let userVC = UIStoryboard.vcInMainSB("PopoverController")
		
		userVC.modalPresentationStyle = .overFullScreen
		
		userVC.modalTransitionStyle = .crossDissolve
		
		present(userVC, animated: true, completion: nil)
		
	}
}
