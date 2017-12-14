//
//  DBModel.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/8/15.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import RealmSwift
import Realm.Private

class DBModel: Object {
	
	@objc dynamic var createtime = Date().timeIntervalSince1970
	
	
	required init(realm: RLMRealm, schema: RLMObjectSchema) {
		super.init(realm: realm, schema: schema)
	}
	
	required init() {
		super.init()
	}
	
	required override init(value: Any) {
		super.init(value: value)
	}
	
	required init(value: Any, schema: RLMSchema) {
		super.init(value: value, schema: schema)
	}
	
    
}
