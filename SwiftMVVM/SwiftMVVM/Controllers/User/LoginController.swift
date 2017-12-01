//
//  LoginController.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/6.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class LoginController: UIViewController, KeyboardHandle {

	@IBOutlet weak var inputBgView: UIView!
	@IBOutlet weak var accountTextField: UITextField!
	@IBOutlet weak var pwdTextField: UITextField!
	@IBOutlet var accountLeftView: UIView!
	
	@IBOutlet weak var bgImgView: UIImageView!
	@IBOutlet var pwdLeftView: UIView!
	
	var viewModel: UserViewModel!
	
	var  provider: HTTPProvider<UserApi>!
	
	override func viewDidLoad() {
		
        super.viewDidLoad()
		
		FileTool().creatFileIfNotExit(name: "testttttt.txt")
		
//		let img = UIImage(named: "IMG_Cool_Car_5")
		
		
//		FileTool(delegate: self).write(data: UIImageJPEGRepresentation(img!, 0.5)!, toFile: "image.png", cover: false)
		
//		let data = FileTool().read(fileName: "image.png")
		
		
		viewModel = UserViewModel()
		
		setupUI()

		// 调用自定义的通知名称
		NotificationCenter.post(name: .loginSuccess, object: nil, userInfo: nil)

		// 调用系统的通知名称
		NotificationCenter.post(name: .UIKeyboardDidHide, object: nil, userInfo: nil)
    }

	/// 设置UI  IMG_Cool_Car_0
	private func setupUI() {
		
		inputBgView.layer.cornerRadius = 5
		inputBgView.layer.borderColor = UIColor(hexColor: "#16b4ef").cgColor
		inputBgView.layer.borderWidth = 1/UIScreen.main.scale
		
		inputBgView.layer.masksToBounds = true
		accountTextField.leftViewMode = .always
		accountTextField.leftView = accountLeftView
		pwdTextField.leftViewMode = .always
		pwdTextField.leftView = pwdLeftView
		
		let imgName = "IMG_Cool_Car_5"
		
		bgImgView.image = UIImage(named: imgName)
	}
	
	/// 登录
	@IBAction func loginAction(_ sender: Any) {
		
		DebugPrint("登录中")
		AutoProgressHUD.showAutoHud("登录中....")

		self.viewModel.login(pwd: self.pwdTextField.text,
							 account: self.accountTextField.text,
							 complete:
			{ [unowned self] country in
				
				DebugPrint("中国一共\(country.provinces.count)个省份，他们分别是：")
				
//				for province in country.provinces {
//
//					DebugPrint("名称: \(province.name), 包含\(province.citys.count)个城市")
//
//				}
				self.loadHomeVC()
								
		})
	}
	
	func loadHomeVC() {
		let kWindow: UIWindow = UIApplication.shared.keyWindow!
		let rootVC = UIStoryboard.vcInMainSB("MainTabBarController")
		rootVC.modalTransitionStyle = .crossDissolve
		UIView.transition(with: kWindow,
						  duration: 1,
						  options: .transitionCrossDissolve,
						  animations: {
							let oldState = UIView.areAnimationsEnabled
							UIView.setAnimationsEnabled(false)
							kWindow.rootViewController = rootVC
							UIView.setAnimationsEnabled(oldState)
							
		}, completion: nil)
		
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	deinit {
		DebugPrint("Controller deinit~~~~")
	}

}


extension LoginController: FileToolProtocol {
	var root: String {
		return "/test"
	}
}
