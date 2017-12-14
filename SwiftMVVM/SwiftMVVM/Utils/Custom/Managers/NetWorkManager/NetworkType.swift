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
	
    var code: Int
    
	var values: [T]?
	
	// Description of Response
	var message: String
}


/// 请求信息
///
/// - responseMsg: 响应信息
/// - success: 成功提示
/// - failure: 失败提示
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


/// 网络请求错误
struct NetError {
	
	var code: Int
	
	var message: String
	
}


/// 网络响应
///
/// - Success: 成功
/// - Failure: 失败
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
    
    var code: Int {
        switch self {
        case .Success(let result):
            return result.code
        case .Failure(let error):
            return error.code
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


// MARK: - 描述
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


// MARK: - debug描述
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
