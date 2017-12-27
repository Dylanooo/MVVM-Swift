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

extension NSAttributedString {
    /// 富文本转换为 HTML文本
    ///
    /// - Parameter attribute  富文本
    /// - Returns: html文本
    func toHTML() -> String {
        let options: [NSAttributedString.DocumentAttributeKey: Any] = [NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html,NSAttributedString.DocumentAttributeKey.characterEncoding: String.Encoding.utf8.rawValue]
        let data = try! self.data(from: NSMakeRange(0, self.length), documentAttributes: options)
        return String(data: data, encoding: .utf8)!
    }

}
