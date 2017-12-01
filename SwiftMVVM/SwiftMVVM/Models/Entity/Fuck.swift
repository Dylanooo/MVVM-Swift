//
//  Fuck.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/17.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class Fuck: DBModel {
	@objc dynamic var desName: String = ""
	
	@objc dynamic var gender: String = ""
	
	@objc dynamic var time: String = ""
	
	@objc dynamic var address: String = ""
	
	@objc dynamic var id: String = ""
	
	override class func primaryKey() -> String? { return "id" }
}
