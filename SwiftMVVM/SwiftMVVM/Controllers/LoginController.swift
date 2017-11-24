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
	var  provider: HTTPApi<UserApi>!
	override func viewDidLoad() {
        super.viewDidLoad()
		viewModel = UserViewModel()
		setupUI()
		
//		var array = [Int]()
//
//		DispatchQueue.concurrentPerform(iterations: 1000) { index in
//			let last = array.last ?? 0
//			array.append(last + 1)
////			sleep(1)
//			DebugPrint("Unsafe loop count: \(last + 1)")
//		}
//
//		DispatchQueue.global(qos: .default).async {
//			//处理耗时操作的代码块...
//			print("do work")
//
//			//操作完成，调用主线程来刷新界面
//			DispatchQueue.main.async {
//				print("main refresh")
//			}
//		}
		
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
		
		viewModel.login(pwd: pwdTextField.text, account: accountTextField.text, complete: { user in

		})
		
		

	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
