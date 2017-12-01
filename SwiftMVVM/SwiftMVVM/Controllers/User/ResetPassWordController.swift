//
//  ResetPassWordController.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/9.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class ResetPassWordController: UIViewController, KeyboardHandle {

	@IBOutlet weak var phoneNumLabel: UILabel!
	@IBOutlet weak var phoneNum: UITextField!
	@IBOutlet weak var verCode: UITextField!
	@IBOutlet weak var verCodeLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	/// 将要输入电话号码
	func shouldInputPhoneNum(_ edited: Bool) {
		if (phoneNum.text ?? "").count == 0 {
			resetPlaceHolderLabelPosition(textField: phoneNum, placeLabel: phoneNumLabel, edited: edited)
		}
	}
	
	/// 将要输入验证码
	func shouldInputVerCode(_ edited: Bool) {
		if (verCode.text ?? "").count == 0 {
			resetPlaceHolderLabelPosition(textField: verCode, placeLabel: verCodeLabel, edited: edited)
		}
	}
	
	
	/// 重新约束占位标签
	///
	/// - Parameters:
	///   - textField: 当前的输入框
	///   - placeLabel: 输入框对应的标签
	func resetPlaceHolderLabelPosition(textField: UITextField, placeLabel: UILabel, edited: Bool) {
		
		UIView.animate(withDuration: 0.25, animations: {
			let transX: CGFloat = edited ? -0.2 * placeLabel.width : 0
			let transY: CGFloat = edited ? -24 : 0
			let scale: CGFloat  = edited ? 0.6 : 1
			placeLabel.transform = CGAffineTransform(translationX: transX , y: transY)
			placeLabel.transform = placeLabel.transform.scaledBy(x: scale, y: scale)
		}, completion: nil)
		
	}
	
	@IBAction func getVerCodeAction(_ sender: Any) {
	}
}


extension ResetPassWordController: UITextFieldDelegate {
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		textField == phoneNum ? shouldInputPhoneNum(true) : shouldInputVerCode(true)
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField == phoneNum ? shouldInputPhoneNum(false) : shouldInputVerCode(false)
	}
}
