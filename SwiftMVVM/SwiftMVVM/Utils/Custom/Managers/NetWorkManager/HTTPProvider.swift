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
	
	func request(_ targetType: Target, responseHandler: @escaping ResponseBlock<Target.EntityType>)  {
		
		NetworkManager.sharedInstance.request(targetType, responseHandler: responseHandler)
		
	}
	
	@discardableResult
	func download(_ targetType: Target, response: @escaping ResponseBlock<Target.EntityType>) -> Alamofire.DownloadRequest {
		
		return NetworkManager.sharedInstance.download(targetType, response: response)
	}
	
	private func downloadProgress(closure: @escaping DownloadProgressBlock) {
		
	}
}
