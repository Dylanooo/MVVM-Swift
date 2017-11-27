//
//  LoginController.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/6.
//  Copyright © 2017年 Autohome.Inc. All rights reserved.
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
		
		viewModel = UserViewModel()
		
		setupUI()
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
			{ country in
				
				DebugPrint("中国一共\(country.provinces.count)个省份，他们分别是：")
				
				for province in country.provinces {
					
					DebugPrint("名称: \(province.name), 包含\(province.citys.count)个城市")
					
				}
				
								
		})

		
		
		

	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
