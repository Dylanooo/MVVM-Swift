//
//  FileManager.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/31.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import Foundation

protocol FileToolProtocol {
	var root: String {get}
}


class FileTool: NSObject {
	
	override init() {
		super.init()
	}
	
	convenience init(delegate: FileToolProtocol) {
		self.init()
		self.delegate = delegate
	}
	
	///  manager for file handling
	private let fileManager: FileManager = {
		
		let fm = FileManager.default
		
		return fm
	}()
	
	private var delegate: FileToolProtocol? = nil
	
	private var root: String {
		
		if let de = delegate {
			
			return de.root
			
		} else {
			
			return "/files"
			
		}
	}
	
	/// base path for file
	private var basePath: String {
		
		return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
		
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
	func creatFileIfNotExit(name filename: String) {
		
		var dirPath = basePath
		
		dirPath = dirPath + root + (filename.hasPrefix("/") ? "" : "/") + filename
		
		creatFileDirectoryIfNotExit("")
		
		var isDir: ObjCBool = false
		
		let fileExit = fileManager.fileExists(atPath: dirPath, isDirectory: &isDir)
	
		if !fileExit {
			
			let sucess = fileManager.createFile(atPath: dirPath, contents: Data(), attributes: nil)
			
			if sucess {
				
				DebugPrint("creat file success")
				
			}
		} else {
			
			DebugPrint("file has existed")
			
		}
	}
	
	/// creat file directory if not exit
	func creatFileDirectoryIfNotExit(_ path: String) {

		var dirPath: String
		
		if path.contains(basePath) {
			dirPath = path
		} else {
			dirPath	= basePath
			
			if path.isEmpty {
				dirPath = dirPath + root
			} else {
				dirPath = dirPath + root + (path.hasPrefix("/") ? "" : "/") + path
			}
			
		}
		
		
		var isDir: ObjCBool = true
		
		fileManager.fileExists(atPath: dirPath, isDirectory: &isDir)
		
		assert(isDir.boolValue, "Error: the path is not a directory")
		
		try! fileManager.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)

	}
	
	
	func write(data: Data, toFile fileName: String, cover: Bool) {
		
		var dirPath = basePath
		
		dirPath = dirPath + root + (fileName.hasPrefix("/") ? "" : "/") + fileName
		
		creatFileIfNotExit(name: fileName)
		
		let fileHandle = FileHandle(forUpdatingAtPath: dirPath)
		
		if let fh = fileHandle {
			
			if cover {
				
				fh.truncateFile(atOffset: 0)
				
			}
		
			fh.seekToEndOfFile()
			
			fh.write(data)
			
			fh.closeFile()
			
		} else {
			
			DebugPrint("write to file failed")
		}
		
	}
	
	func read(fileName: String) -> Data? {
		
		var dirPath = basePath
		
		dirPath = dirPath + root + (fileName.hasPrefix("/") ? "" : "/") + fileName
		
		let fileExit = fileManager.fileExists(atPath: dirPath, isDirectory: nil)
		
		if !fileExit {
			
			DebugPrint("file not exist")
			
			return nil
			
		}
		
		let fileHandle = FileHandle(forReadingAtPath: dirPath)
		
		if let fh = fileHandle {
			
			let data = fh.readDataToEndOfFile()
			
			fh.closeFile()
			
			return data
			
		} else {
			
			DebugPrint("read file content failed")
			
			return nil
			
		}
		
	}
	
	/// delete file
	///
	/// - Parameter fileName: the name of need deleted
	func delete(file fileName: String) {
		
		var dirPath = basePath
		
		dirPath = dirPath + root + (fileName.hasPrefix("/") ? "" : "/") + fileName
		
		try? fileManager.removeItem(atPath: dirPath)
	}
	
	
	/// delete directory
	///
	/// - Parameter path: the path need deleted
	func deleteDirectory(_ path: String) {
		
		assert(!path.contains(basePath), "Error: you don`t need set the base directory")
		
		var dirPath = basePath
		
		if path.isEmpty {
			dirPath = dirPath + root
		} else {
			dirPath = dirPath + root + (path.hasPrefix("/") ? "" : "/") + path
		}
		
		try? fileManager.removeItem(atPath: dirPath)
	}
	
	
	/// delete all items in dir
	///
	/// - Parameter dirName: directory name
	func deleteItems(inDir dirName: String) {
		
		deleteDirectory(dirName)
		
		creatFileDirectoryIfNotExit(dirName)
		
	}
}
