//
//  SignInController.swift
//  SwiftMVVM
//
//  Created by Dylan.Lee on 13/12/2017.
//  Copyright © 2017 Dylan.Lee. All rights reserved.
//

import UIKit

class SignInOneController: UIViewController, KeyboardHandle {

    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var phoneNum: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let nextBtn = UIBarButtonItem(title: NSLocalizedString("Title:next", comment: ""),
                                      titleColor: .lightGray,
                                      target: self,
                                      action: #selector(showNextPage))
        
        navigationItem.setRightBarButton(nextBtn, animated: true)
        
    }
    
    @objc func showNextPage() {
        
        guard let phoneNum = phoneNum.text, !phoneNum.isEmpty else {
            AutoProgressHUD.showAutoHud(NSLocalizedString("Tips:mobile_null", comment: ""))
            return
        }
        
        let nextVC: SignInTwoController = UIStoryboard.vcInMainSB("SignInTwoController") as! SignInTwoController
        nextVC.phoneNumber = phoneNum
        navigationController?.pushViewController(nextVC, animated: true)
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

extension SignInOneController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == phoneNum {
            shouldInputPhoneNum(true)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == phoneNum {
            shouldInputPhoneNum(false)
        }
        
    }
}
