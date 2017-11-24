//
//  NetWorkType.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/27.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
public typealias DownloadDestination = Alamofire.DownloadRequest.DownloadFileDestination

public typealias Method = Alamofire.HTTPMethod

struct Result<T> {
	
	// Response`s Value
	var value: T?
	
	var values: [T]?
	
	// Description of Response
	var message: String
}

enum Message {
	
	case responseMsg(String)
	
	case success
	
	case failure
	
	func retMsg() -> String {
		
		switch self {
			
		case .responseMsg(let msg):
			
			return msg
			
		case .success:
			
			return NetworkConfig.kSuccessMsg
			
		case .failure:
			
			return NetworkConfig.kErrorMsg
			
		}
	}
}

struct NetError {
	
	var code: Int
	
	var message: String
	
}

enum Response<T> {
	
	case Success(Result<T>)
	
	case Failure(NetError)
	
	var success: Bool {
		
		switch self {
			
		case .Success:
			
			return true
			
		case .Failure:
			
			return false
			
		}
	}
	
	var failure: Bool {
		
		return !success
		
	}
	
	var value: T? {
		
		switch self {
			
		case .Success(let result):
			
			return result.value
			
		case .Failure:
			
			return nil
			
		}
	}
	
	var values: [T]? {
		
		switch self {
			
		case .Success(let result):
			
			return result.values
			
		case .Failure:
			
			return nil
			
		}
	}
	
	
	var message: String {
		
		switch self {
			
		case .Success(let result):
			
			return result.message
			
		case .Failure(let error):
			
			return error.message
			
		}
	}
}

extension Response: CustomStringConvertible {
	
	var description: String {
		
		switch self {
			
		case .Success:
			
			return "SUCCESS"
			
		case .Failure:
			
			return "FAILURE"
			
		}
	}
}

extension Response: CustomDebugStringConvertible {
	
	var debugDescription: String {
		
		switch self {
			
		case .Success(let value):
			
			return "SUCCESS: \(value)"
			
		case .Failure(let error):
			
			return "FAILURE: \(error)"
			
		}
	}
}

typealias ConstructingBodyWithBlock = (_ formData:MultipartFormData?) -> ()

typealias ResponseBlock<T> = (_ resp: Response<T>) -> ()

typealias DownloadRequest = Alamofire.DownloadRequest

typealias DownloadProgressBlock = (Progress) -> Void

typealias DownloadBlock<T> = (_ resp: Response<T>, _ fileName: String) -> ()

typealias ProgressBlock = ((Progress) -> Void)?

public func NetWorkRetCode(_ responseData: [String: JSON]) -> Int {
	
	return responseData[NetworkConfig.kRetCode]?.int ?? 0
}

public func NetworkRetMsg(_ responseData: [String: JSON]) -> String {
	
	return responseData[NetworkConfig.kRetMsg]?.string ?? ""
	
}

public func NetworkRetData(_ responseData: [String: JSON]) -> SwiftyJSON.JSON {
	
	guard let retData = responseData[NetworkConfig.kRetData] else {
		return JSON([:])
	}
	return retData
	
}
