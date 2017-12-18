//
//  UIViewControllerExt.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/7.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit


/// comply with the protocol to hide the keyboard
public protocol KeyboardHandle {}

extension UIViewController {
	
	static let cmp_swizzleMethod: Void = {
		DispatchQueue.once(UUID().uuidString) {
			
			swizzleMethod(UIViewController.self,
						  originalSelector: #selector(UIViewController.viewDidLoad),
						  swizzleSelector: #selector(UIViewController.cm_viewDidLoad))
			
			swizzleMethod(UIViewController.self,
						  originalSelector: #selector(UIViewController.prepare(for:sender:)),
						  swizzleSelector: #selector(UIViewController.cm_prepare(for:sender:)))
			
		}
	}()
	
	@objc func cm_viewDidLoad() {
		cm_viewDidLoad()
		setupBackItem()
		if let _ = self as? KeyboardHandle {
			setupHideKeyboard()
		}
	}
	
	@objc func cm_prepare(for segue: UIStoryboardSegue, sender: Any?) {
		segue.destination.hidesBottomBarWhenPushed = true
		cm_prepare(for: segue, sender: sender)
	}
	
	/// set the handler for hide keyboard
	private func setupHideKeyboard() {
		let tap = UITapGestureRecognizer(target: self,
										 action: #selector(hideKeyboardAction))
		view.addGestureRecognizer(tap)
	}
	
	/// hide the keyboard
	@objc private func hideKeyboardAction() {
		view.endEditing(true)
	}
	
	func setupBackItem() {
		
		guard !(self is UINavigationController) else {
			return
		}
		
		guard navigationController != nil else {
			return
		}
		
		guard (navigationController?.viewControllers.count ?? 0) > 1 else {
			return
		}
        
        let imgName = (navigationController is HideTopNavBarController) ? "icon_back_arrow_gray" : "icon_back_arrow"
        
		navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(named: imgName),
															target: self,
															action: #selector(popToLastVC))
        
		navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
	}
	
	@objc func popToLastVC() {
		navigationController?.popViewController(animated: true)
	}
}
