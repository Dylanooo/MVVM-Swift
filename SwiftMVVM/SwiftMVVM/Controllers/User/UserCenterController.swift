//
//  UserCenterController.swift
//  SwiftMVVM
//
//  Created by Dylan.Lee on 14/12/2017.
//  Copyright © 2017 Dylan.Lee. All rights reserved.
//

import UIKit

class UserCenterController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headPicView: UIImageView!
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        let db = DataBaseManager.default
        user = db.queryObjects(type: User.self).first
        headPicView.kf.setImage(with: URL(string: user?.headPic ?? ""))
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
                title = NSLocalizedString("Title:user_id", comment: "") + "\(user.id)"
            case 1:
                title = NSLocalizedString("Title:user_name", comment: "") + user.name
            case 2:
                title = NSLocalizedString("Title:user_age", comment: "") + "\(user.age)" + NSLocalizedString("Title:age", comment: "");
            case 3:
                title = NSLocalizedString("Title:user_nickname", comment: "") + user.nickName
            case 4:
                title = NSLocalizedString("Title:user_address", comment: "") + user.address
            case 5:
                title = NSLocalizedString("Title:user_gender", comment: "") + (user.gender == 0 ? NSLocalizedString("Title:gender_female", comment: "") : NSLocalizedString("Title:gender_male", comment: ""))
            case 6:
                title = NSLocalizedString("Title:user_mobile", comment: "") + user.mobile
            case 7:
                title = NSLocalizedString("Title:user_password", comment: "") + user.pwd
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
