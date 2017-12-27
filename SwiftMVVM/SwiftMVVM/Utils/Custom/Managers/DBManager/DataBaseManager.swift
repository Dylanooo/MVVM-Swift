//
//  DataBaseManager.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/25.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import RealmSwift

private let dbVersion: UInt64 = 2

class DataBaseManager {
	
	
	public class var `default`: DataBaseManager {
		return DataBaseManager()
	}
	
	/// 默认数据库变量
	private lazy var realm = { () -> Realm in
	
		DebugPrint(DataBaseManager.config.fileURL?.absoluteString ?? "")
		Realm.Configuration.defaultConfiguration = DataBaseManager.config
		
		let db = try! Realm()
		
		return db
	}()
	
	private static let config = Realm.Configuration(fileURL: fileURL,
													schemaVersion: dbVersion,
													migrationBlock: { (migration, oldSchemaVersion) in
		if oldSchemaVersion < dbVersion {
			
		}
		})
	
	private static let fileURL: URL = {
		
		let docPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory,
																  .userDomainMask,
																  true).first!
		
		var path = docPath + "/DataBase/"
		
		FileTool().creatFileDirectoryIfNotExit(path)
		
		path += "MVVM.realm"
		
		return URL(string: path)!
	}()

	
	/// 查询
	///
	/// - Parameter type: 所查询的数据类型
	/// - Returns: 查询结果
	///		let dm = DataBaseManager.default
	///		let tests = dm.queryObjects(type: Test.self)
	func queryObjects<T: DBModel>(type: T.Type) -> Results<T> {
		let results = realm.objects(type)
		return results
	}
	
	
	/// 插入或更新数据
	///
	/// - Parameter objects: 需要插入的数据
	///		let testDic: [String: Any?] = ["time": "2017-08-12", "author": "Dylan.Lee001", "articleid": 1, "title": "测试数据库工具", "id": "002"];
	///		let test = Test(value: testDic)
	/// 	let dm = DataBaseManager.default
	///	    dm.insertOrUpdate(objects: [test])
	func insertOrUpdate<T: DBModel>(objects: [T]) {
		try! realm.write({
			realm.add(objects, update: true)
		})
	}
	
	
	/// 删除数据
	///
	/// - Parameter objects: 需要删除的数据
	/// 	let dm = DataBaseManager.default
	///		dm.deleteObjects(objects: [user])
	func deleteObjects<T: DBModel>(objects: [T]) {
		try! realm.write({ 
			realm.delete(objects)
		})
	}
    
    func deleteAllObjects<T: DBModel>(type: T.Type) {
        let objs = queryObjects(type: T.self)
        try! realm.write({
            realm.delete(objs)
        })
    }
	
	
}

extension DataBaseManager: FileToolProtocol {
	var root: String {
		return "/DataBase"
	}
}
