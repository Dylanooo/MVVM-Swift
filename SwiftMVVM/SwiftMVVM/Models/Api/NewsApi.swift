//
//  NewsApi.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/27.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

enum NewsApi<T> {
	case login
	
	case Image(count: Int, page: Int)
	
	case regester
	
	case xxx
}

extension NewsApi: Request {

	typealias EntityType = T

	var path: String {
		
		switch self {
			
		case .login:
			
			return "/login/news"
			
		case .regester:
			
			return "/regester/news"
			
		default:
			
			return "/xxx/mm"
			
		}
	}
	
	var parameters: [String: Any]? {
		
		switch self {
			
		case .Image(let X, let Y):
			
			return ["x": X, "y": Y]
			
		default:
			
			return [:]
		}
	}
}
