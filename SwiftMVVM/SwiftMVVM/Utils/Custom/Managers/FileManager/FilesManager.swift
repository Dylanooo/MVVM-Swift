//
//  FileManager.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/31.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import Foundation

class FilesManager: NSObject {
	
	
	///  manager for file handling
	let fileManager: FileManager = {
		
		let fm = FileManager.default
		
		return fm
	}()
	
	/// base path for file
	public var basePath: String {
		
		return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
		
	}
	
	/// default instance of file manager
	public class var `default`: FilesManager {
		
		return FilesManager()
		
	}
	
	/// get data from file path
	func data(filePath: String) -> Any? {
		
		do {
		
			let attributes = try fileManager.attributesOfFileSystem(forPath: filePath)
			
			return attributes

		} catch {
			
			print(error)
			
			return nil
			
		}
		
	}
	
	/// creat file if not exit
	func creatFileIfNotExit(path: String) {
		
		var isDir: ObjCBool = false
		
		let fileExit = fileManager.fileExists(atPath: path, isDirectory: &isDir)
		
		assert(!isDir.boolValue, "Error: the path is not a file")
		
// TODO: 未实现
		if !fileExit {
//			fileManager.createFile(atPath: <#T##String#>, contents: <#T##Data?#>, attributes: <#T##[String : Any]?#>)
		}
	}
	
	/// creat file directory if not exit
	func creatFileDirectoryIfNotExit(_ path: String) {
		
		var isDir: ObjCBool = true
		
		fileManager.fileExists(atPath: path, isDirectory: &isDir)
		
		assert(isDir.boolValue, "Error: the path is not a directory")
		
		try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)

	}
}
