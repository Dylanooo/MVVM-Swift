//
//  UserApi.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/6.
//  Copyright © 2017年 Autohome.Inc. All rights reserved.
//

enum UserApi {
	case login
	case Image(count:Int,page:Int)
	case regester
	case xxx
	case download
}

extension UserApi: Request {


	/// 请求返回实体类型
	typealias EntityType = Country


	/// host 如果项目中所有host可以保持一致，直接在Request中设置默认Host，在具体的Api中可省略
	var baseURL: String {
		
		switch self {
			
		case .xxx:
			
			return "http://www.baidu.com"
			
		default:
			
			return "http://comm.app.autohome.com.cn"
			
		}
	}


	/// 具体业务对应的path
	var path: String {
		
		switch self {
			
		case .login:
			
			return "/news/province-pm2-ts0.json"
			
		case .regester:
			
			return "/regester"
			
		case .download:
			
			return "http://7xoyls.com1.z0.glb.clouddn.com/%E9%99%88%E5%A5%95%E8%BF%85-%E4%B8%80%E4%B8%9D%E4%B8%8D%E6%8C%82%20%28Live%29.mp3"
			
		default:
			
			return ""
			
		}
	}
	
	/// 参数
	var parameters: [String: Any]? {
		
		switch self {
			
		case .Image(let X, let Y):
			
			return ["x": X, "y": Y]
			
		default:
			
			return [:]
			
		}
	}
}
