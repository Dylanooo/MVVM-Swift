//
//  UserApi.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/26.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class User: DBModel {
	
	@objc dynamic var name: String = ""
	
    @objc dynamic var age: Int = 0
    
	@objc dynamic var gender: Int = 0
    
    @objc dynamic var address: String = ""
    
    @objc dynamic var nickName: String = ""
    
    @objc dynamic var pwd: String = ""
    
    @objc dynamic var mobile: String = ""
    
    @objc dynamic var headPic: String = ""
	
	@objc dynamic var id: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

