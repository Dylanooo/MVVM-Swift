//
//  TestApi.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/6.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

enum TestApi {
	
	case login
	
	case Image(count:Int,page:Int)
	
	case regester
	
	case xxx
	
}

extension TestApi: Request {
	
	typealias EntityType = Test
	
	
	var baseURL: String {
		
		return "http://app.mall.autohome.com.cn"
		
	}
	
	var path: String {
		
		switch self {
			
		case .login:
			
			return "/user/timestamp.mm"
			
		case .regester:
			
			return "/headline/getDownNewsList"
			
		default:
			
			return "/xxx"
		}
	}
	
	var method: Method {
		
		switch self {
			
		case .login:
			
			return .get
			
		default:
			
			return .post
			
		}
	}
	
	var parameters: [String: Any]? {
		
		switch self {
			
		case .Image(let X, let Y):
			
			return ["x": X, "y": Y]
			
		case .regester:
			
			return ["_appid": "mall", "_maxtimestamp": 0,
					
					"_mintimestamp": 0, "tags": "奇点汽车,理念,宝马,捷豹",
					
					"timestamp": 1501140483, "_sign": "255ACBF34375C6A7E1EE4F7B2B30028B"]
		default:
			
			return [:]
		}
	}
}

