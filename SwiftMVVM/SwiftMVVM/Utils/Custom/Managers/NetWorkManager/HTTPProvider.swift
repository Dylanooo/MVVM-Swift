//
//  Provider.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/27.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import Alamofire


class HTTPProvider<Target: Request> where Target.EntityType: DBModel {
	
    private let manager = NetworkManager.sharedInstance
	
	/// 网络请求
	///
	/// - Parameters:
	///   - targetType: Api模型
	///   - responseHandler: 请求回调
    func request(_ targetType: Target, responseHandler: @escaping ResponseBlock<Target.EntityType>)  {
		
        manager.request(targetType, responseHandler: responseHandler)
		
	}
	
	@discardableResult
	func download(_ targetType: Target, response: ResponseBlock<Target.EntityType>) -> Alamofire.DownloadRequest {
		
		return NetworkManager.sharedInstance.download(targetType, response: response)
	}
	
    func upload(_ targetType: Target, response: @escaping ResponseBlock<Target.EntityType>) {
        
        NetworkManager.sharedInstance.upload(targetType, responseHandler: response)
    }
    
	private func downloadProgress(closure: DownloadProgressBlock) {
		
	}
}
