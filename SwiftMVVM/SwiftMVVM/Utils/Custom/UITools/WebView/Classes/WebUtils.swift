//
//  WebUtils.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/9/12.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import WebKit

class WebUtils {
	static let defaultDomain = ".mvvm.com.cn"
	class func addCookies(_ cookieCouples: [String: Any], forURL additionalURL: String, domain: String = defaultDomain) {
		
		
		let cookieStorage = HTTPCookieStorage.shared
		
		let url = URL(string: additionalURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
		
		cookieStorage.cookieAcceptPolicy = .always
		
		let cookies = getHTTPCookies(couples: cookieCouples, domain: domain)
		
		cookieStorage.setCookies(cookies, for: url, mainDocumentURL: URL(string: domain))
		
	}
	
	class func getHTTPCookies(couples: [String: Any], domain: String) -> [HTTPCookie] {
		var cookies = [HTTPCookie]()
		
		for (key, value) in couples {
			
			let cookieInfo: [HTTPCookiePropertyKey: Any] = [.name: key,
			                                                .value: value,
			                                                .path: "/",
			                                                .domain: domain,
			                                                .expires: Date(timeIntervalSinceNow: 365*24*3600).description]
			
			let cookie = HTTPCookie(properties: cookieInfo)
			
			if let co = cookie {
				cookies.append(co)
			}
		}
		return cookies
	}
}


extension WKWebView {
	func setCookies(_ cookieCouple: [String: Any], domain: String = WebUtils.defaultDomain,completeHandler: @escaping ((Any?, Error?)->())) {
		
		let tzGMT = TimeZone(abbreviation: "GMT")
		NSTimeZone.default = tzGMT!
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss 'GMT'"
		dateFormatter.locale = Locale(identifier: "en_US")
		let cookies = WebUtils.getHTTPCookies(couples: cookieCouple, domain: domain)
		var cookieMethod = ""
		for cookie in cookies {
			let dateStr = dateFormatter.string(from: cookie.expiresDate!)
			cookieMethod.append("document.cookie = '\(cookie.name)=\(cookie.value); domain=\(cookie.domain); path=\(cookie.path); expires=\(dateStr);';")
		}
		evaluateJavaScript(cookieMethod) { (info, error) in
			completeHandler(info, error)
		}
	}
}













