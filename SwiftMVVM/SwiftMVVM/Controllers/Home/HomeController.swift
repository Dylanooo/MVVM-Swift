//
//  HomeController.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/25.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import Alamofire

class HomeController: UIViewController {

	@IBOutlet weak var flowUpCenter: NSLayoutConstraint!
	
	@IBOutlet weak var matchCenter: NSLayoutConstraint!
	@IBOutlet weak var followUPView: UIButton!
	
	@IBOutlet weak var itemWidth: NSLayoutConstraint!
	@IBOutlet weak var matchView: UIButton!
	@IBOutlet weak var topView: UIView!
	@IBOutlet weak var segmentView: UIView!
	
	var viewModel: HomeViewModel {
		return HomeViewModel()
	}
	
	override func viewDidLoad() {
		
        super.viewDidLoad()
		
		setupUI()
		
		viewModel.setupLoaction()
		
		let testDic: [String: Any?] = ["time": "2017-08-12", "author": "dylanlee", "articleid": 1, "title": "测试数据库工具", "id": "002"];
		let test = Test(value: testDic)
		let dm = DataBaseManager.default
		dm.insertOrUpdate(objects: [test])
		
		let fuckDic: [String: Any?] = ["desName": "lily", "gender": "women", "time": "2017-11-17", "address": "七天酒店", "id": "001"]
		let fuck = Fuck(value: fuckDic)
		dm.insertOrUpdate(objects: [fuck])
        
        
    }
	
	func setupUI() {
		flowUpCenter.constant = -kScreenWidth/4
		matchCenter.constant = kScreenWidth/4
		itemWidth.constant = kScreenWidth/4
		followUPView.roundCorner(kScreenWidth/8)
		matchView.roundCorner(kScreenWidth/8)

		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75) {
			UIView.animate(withDuration: 4, animations: {
				self.topView.alpha = 1
				self.segmentView.alpha = 1
			})
		}
	}
	
	@objc func testRequire() {
		
		
	}
	
	
	@IBAction func showNeedFollowUpAction(_ sender: Any) {
		let vc = UIViewController()
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@IBAction func needMatchAction(_ sender: Any) {
	}
}
