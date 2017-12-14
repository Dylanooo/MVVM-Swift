//
//  File.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/27.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
public enum UpLoadType {
    case data
    case path
}

public class File {
	
	var data: Data = Data()
	
	var name: String = ""
    
    var uploadType: UpLoadType = .data
	
	var mimeType: String = ""
	
	var filePath: String = ""
	
	init(data: Data? = nil, name: String, mimeType: String, filePath: String? = nil) {
		
        if let d = data {
            self.data = d
        }
        
        if let path = filePath {
            self.filePath = path
        }
        
        assert(data != nil || data != nil, "至少传入一个数据源")
		
		self.name = name
		
		self.mimeType = mimeType
		
	}
}
