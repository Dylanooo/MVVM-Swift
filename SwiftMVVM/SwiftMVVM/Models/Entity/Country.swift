//
//  Country.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/24.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import RealmSwift

class Country: DBModel {
	
	@objc dynamic var id: Int = 0
	
	@objc dynamic var timestamp: Int64 = 0
	
	var provinces = List<Province>()

}
