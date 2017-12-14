//
//  TargetType.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/26.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import Foundation
import Alamofire

public protocol Request {
	/// The target`s base 'URL'.
	var baseURL: String { get }
	
	/// *The path to be appended to 'baseURL' to form the full 'URL'.
	var path: String { get }
	
	/// The HTTP method used in the request.
	var method: Method { get }
	
	/// The parameters for request
	var parameters: [String: Any]? { get }
	
	
	/// If upload files ,the next properties is necessary
	
	/// The files path collection
	var files: [File]? { get }
	
	associatedtype EntityType
	
}


// MARK: - 设置默认数据
public extension Request {
	
	var baseURL: String {
		return NetworkConfig.kBaseURL
	}
	
	var method: Method {
		return .get
	}
	
	var parameters: [String: Any]? {
		return [:]
	}
	
	var files: [File]? {
		return []
	}
}
