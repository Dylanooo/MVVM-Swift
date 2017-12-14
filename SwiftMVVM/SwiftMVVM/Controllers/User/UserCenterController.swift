//
//  UserCenterController.swift
//  SwiftMVVM
//
//  Created by 李海洋 on 14/12/2017.
//  Copyright © 2017 Dylan.Lee. All rights reserved.
//

import UIKit

class UserCenterController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = DataBaseManager.default
        user = db.queryObjects(type: User.self).first
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logoutAction(sender: Any) {
        
        let db = DataBaseManager.default
        db.deleteAllObjects(type: User.self)

        GlobalUIManager.loadLoginVC()
        
    }
    
}

extension UserCenterController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.detailTextLabel?.text = ""
        var title: String = ""
        
        if let user = user {
            switch indexPath.row {
            case 0:
                title = "编号：" + "\(user.id)"
            case 1:
                title = "姓名：" + user.name
            case 2:
                title = "年龄：" + "\(user.age)岁"
            case 3:
                title = "昵称：" + user.nickName
            case 4:
                title = "地址：" + user.address
            case 5:
                title = "性别：" + (user.gender == 0 ? "女" : "男")
            case 6:
                title = "电话：" + user.mobile
            case 7:
                title = "密码：" + user.pwd
            default:
                title = ""
            }
        }
        cell.textLabel?.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
}
