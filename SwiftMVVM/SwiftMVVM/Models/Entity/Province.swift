//
//  Province.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/20.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import RealmSwift

class Province: DBModel {
	
	@objc dynamic var id: Int = 0
	
	@objc dynamic var firstletter: String = ""
	
	@objc dynamic var name: String = ""


	/// 设置与Contry的一对多关系
	let owner = LinkingObjects(fromType: Country.self, property: "provinces")


	/// 设置与cities的一对多关系， 保持字段名称与服务端返回一致
	let citys = List<City>()
	
}
