//
//  File.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/27.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

public class File {
	
	var data: Data = Data()
	
	var name: String = ""
	
	var mimeType: String = ""
	
	var filePath: String = ""
	
	init(data: Data, name: String, mimeType: String, filePath: String) {
		
		self.data = data
		
		self.name = name
		
		self.mimeType = mimeType
		
		self.filePath = filePath
		
	}
}
