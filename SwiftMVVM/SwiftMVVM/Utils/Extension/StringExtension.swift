//
//  StringExt.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/9/22.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

extension String {
	
	//将原始的url编码为合法的url
	func urlEncoded() -> String {
		let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
			.urlQueryAllowed)
		return encodeUrlString ?? ""
	}
	
	//将编码后的url转换回原始的url
	func urlDecoded() -> String {
		return self.removingPercentEncoding ?? ""
	}
}
