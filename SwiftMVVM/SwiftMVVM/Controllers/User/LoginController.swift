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
		print("测试环境")
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
		AutoProgressHUD.showHud(NSLocalizedString("Tips:be_logging_in", comment: ""))
        
        guard let pwd = self.pwdTextField.text, let account = self.accountTextField.text else {
            AutoProgressHUD.showAutoHud(NSLocalizedString("Tips:account_null", comment: ""))
            return
        }

        if pwd.isEmpty || account.isEmpty {
            AutoProgressHUD.showAutoHud(NSLocalizedString("Tips:account_null", comment: ""))
            return
        }

        self.viewModel.login(pwd: pwd,
                             account: account,
                             complete: { user in
                                
                if let user = user  {
                    AutoProgressHUD.hideHud()
                    let dm = DataBaseManager.default
                    dm.deleteAllObjects(type: User.self)
                    dm.insertOrUpdate(objects: [user])
                    GlobalUIManager.loadHomeVC()
                    
                } else {
                    
                    AutoProgressHUD.showAutoHud(NSLocalizedString("Tips:login_failed", comment: ""))
                    
                }
                
        })
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
