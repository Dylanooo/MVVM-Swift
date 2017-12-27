//
//  UserApi.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/6.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//
import UIKit
enum UserApi {
    case login(mobile: String, passwd: String)
	case Image(count:Int,page:Int)
	case register(mobile: String, passwd: String)
	case xxx
	case download
    case upload(parameters: [String: Any])
}

extension UserApi: Request {


	/// 请求返回实体类型
	typealias EntityType = User


	/// host 如果项目中所有host可以保持一致，直接在Request中设置默认Host，在具体的Api中可省略
	var baseURL: String {
        return "http://10.169.2.43:5000/api/user/"
	}


	/// 具体业务对应的path
	var path: String {
		
		switch self {
			
		case .login:
			
			return "login"
			
		case .register:
			
			return "register"
			
		case .download:
			
			return "http://7xoyls.com1.z0.glb.clouddn.com/%E9%99%88%E5%A5%95%E8%BF%85-%E4%B8%80%E4%B8%9D%E4%B8%8D%E6%8C%82%20%28Live%29.mp3"
        
        case .upload(_):
            
            return "updateHeadPic"
            
		default:
			
			return ""
			
		}
	}
	
	/// 参数
	var parameters: [String: Any]? {
		
		switch self {
			
		case .Image(let X, let Y):
			
			return ["x": X, "y": Y]
            
        case .upload(let parameters):
            
            return parameters
        
        case .login(let mobile, let passwd):
            
            return ["mobile": mobile, "password": passwd]
        
        case .register(let mobile, let passwd):
            
            return ["mobile": mobile, "pwd": passwd]
            
		default:
			
			return [:]
			
		}
	}
    
    var method: Method {
        switch self {
        case .download:
            return .get
        case .login:
            return .post
        default:
            return .post
        }
    }
    
    var files: [File]? {
        switch self {
        case .upload(_):
            
            let data = UIImageJPEGRepresentation(UIImage(named: "IMG_Cool_Car_0")!, 1)
            
            let file = File(data: data, name: "IMG_Cool_Car_0.jpg", mimeType: "image/jpg", filePath: nil)
            
            return [file]
            
        default:
            
            return []
        }
    }
}
