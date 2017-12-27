//
//  SignInTwoController.swift
//  SwiftMVVM
//
//  Created by Dylan.Lee on 13/12/2017.
//  Copyright © 2017 Dylan.Lee. All rights reserved.
//

import UIKit

class SignInTwoController: UIViewController, KeyboardHandle {
    
    var phoneNumber: String = ""
    @IBOutlet weak var newPwdLabel: UILabel!
    @IBOutlet weak var newPwd: UITextField!
    @IBOutlet weak var validatePwd: UITextField!
    @IBOutlet weak var validatePwdLabel: UILabel!
    
    var vm: UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = UserViewModel()
        let completeBtn = UIBarButtonItem(title: NSLocalizedString("Title:complete", comment: ""),
                                          titleColor: .lightGray,
                                          target: self,
                                          action: #selector(completeAction))
        navigationItem.setRightBarButton(completeBtn, animated: true)
    }
    
    @objc func completeAction() {
        
        guard let pwd = newPwd.text, let _ = validatePwd.text else {
            AutoProgressHUD.showAutoHud(NSLocalizedString("Title:password_null", comment: ""))
            return
        }
        
        guard !pwd.isEmpty else {
            AutoProgressHUD.showAutoHud(NSLocalizedString("Title:password_null", comment: ""))
            return
        }
        
        vm.register(pwd: pwd, account: phoneNumber) {[weak self] user in
            if user != nil {
                AutoProgressHUD.showAutoHud(NSLocalizedString("Title:register_success", comment: ""))
                self?.navigationController?.popToRootViewController(animated: true)
            } else {
                AutoProgressHUD.showAutoHud(NSLocalizedString("Title:register_failed", comment: ""))
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /// 将要输入电话号码
    func shouldInputNewPwd(_ edited: Bool) {
        if (newPwd.text ?? "").count == 0 {
            resetPlaceHolderLabelPosition(textField: newPwd, placeLabel: newPwdLabel, edited: edited)
        }
    }
    
    /// 将要输入验证码
    func shouldInputValidatePwd(_ edited: Bool) {
        if (validatePwd.text ?? "").count == 0 {
            resetPlaceHolderLabelPosition(textField: validatePwd, placeLabel: validatePwdLabel, edited: edited)
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

}

extension SignInTwoController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField == newPwd ? shouldInputNewPwd(true) : shouldInputValidatePwd(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField == newPwd ? shouldInputNewPwd(false) : shouldInputValidatePwd(false)
    }
}
