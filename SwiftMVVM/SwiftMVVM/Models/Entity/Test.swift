//
//  TestApi.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/27.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit


class Test: DBModel {
	
	@objc dynamic var time = ""
	
	@objc dynamic var author = ""
	
	@objc dynamic var articleid = 0
	
	@objc dynamic var title = ""
	
	@objc dynamic var id = ""
	
	override class func primaryKey() -> String? { return "id" }
}

