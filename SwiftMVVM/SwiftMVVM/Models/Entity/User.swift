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
	
	@objc dynamic var gender: Int = 0
	
	@objc dynamic var mobilePhone: String = ""
	
	@objc dynamic var id: Int = 0
}

