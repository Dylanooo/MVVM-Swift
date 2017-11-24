//
//  WKWebViewController.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/9/12.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//
//	----------------------------------------------------------------------------
//
//  WKWebView (慎用-除非页面内要求客户端与服务端数据交互较少)
//	优点:
//    1.UI层次的可操作性很高，用户手势交互更方便
//	  2.可以对页面的Alert操作进行自定义，而且用户必须实现相应代理，否则用户看不到任何反馈
//    3.开发者可以捕获的网页状态更加丰富，如： receiveRedirect
//    4.性能更加良好
//	  5.可在页面加载前决定在Document头或者尾部注入js代码
//  缺点:
//    1.Cookie操作复杂，需要通过使用WKUserScript，调用js函数来 Set-Cookie
//    2.如果服务端在 Redirect过程中埋入Cookie，在落地页无法取到相应的Cookie
//    3.WKWebView无法缓存Cookie,所以开发者每次进入新的WKWebView的时候必须手动写入Cookie,并且各页面之间Cookie无法共享
//    4.无法实现页面缓存


import UIKit
import Foundation
import WebKit

extension WebViewController {
	
	/// 设置WKWebView
	func setupWKWebView() {
		
		// 设置缓存
		if #available(iOS 9.0, *), needCache {
			
			let webSiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
			
			let dateFrom = Date(timeIntervalSince1970: 0)
			
			WKWebsiteDataStore.default().removeData(ofTypes: webSiteDataTypes, modifiedSince: dateFrom, completionHandler: {
				
				DebugPrint("清理缓存")
				
			})
		}
		
		
		let userContentController = WKUserContentController()
		
		let cookieScript = WKUserScript(source: "",
		                                injectionTime: .atDocumentStart,
		                                forMainFrameOnly: false)
		
		userContentController.addUserScript(cookieScript)
		
		let webConfig = WKWebViewConfiguration()
		
		webConfig.userContentController = userContentController
		
		webConfig.selectionGranularity = .character
		
		webConfig.preferences.javaScriptCanOpenWindowsAutomatically = true
		
		let wkWebView = WKWebView(frame: CGRect.zero, configuration: webConfig)
		
		wkWebView.scrollView.bounces = true
		
		wkWebView.scrollView.contentInset = UIEdgeInsets.zero
		
		wkWebView.scrollView.keyboardDismissMode = .onDrag
		
		wkWebView.scrollView.showsVerticalScrollIndicator = false
		
		wkWebView.translatesAutoresizingMaskIntoConstraints = false
		
		wkWebView.allowsBackForwardNavigationGestures = true
		
		wkWebView.navigationDelegate = self
		
		wkWebView.uiDelegate = self
		
		webView = wkWebView
		

	}
}

extension WebViewController: WKUIDelegate {
	
	func webView(_ webView: WKWebView,
	             runJavaScriptAlertPanelWithMessage message: String,
	             initiatedByFrame frame: WKFrameInfo,
	             completionHandler: @escaping () -> Void) {
		
		let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
		
		alertVC.addAction(UIAlertAction(title: "确认", style: .default, handler: { action in
			
			completionHandler()
			
		}))
		present(alertVC, animated: true, completion: nil)
	}
	
	func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
		let alertVC = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
		
		alertVC.addAction(UIAlertAction(title: "确认", style: .default, handler: { action in
			
			completionHandler(true)
			
		}))
		
		alertVC.addAction(UIAlertAction(title: "取消", style: .default, handler: { action in
			
			completionHandler(false)
			
		}))
		present(alertVC, animated: true, completion: nil)
	}
	

}

extension WebViewController: WKNavigationDelegate {

	func webView(_ webView: WKWebView,
	             decidePolicyFor navigationResponse: WKNavigationResponse,
	             decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
		
		decisionHandler(.allow)
		
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		
		webView.setCookies(["app_keyyyy": "mall_iphone", "app_verrrrrr": "fuck", "app_source": "isapp"]) { info, error in
			
		}

	}
	
	func webView(_ webView: WKWebView,
	             didFail navigation: WKNavigation!,
	             withError error: Error) {
		
	}
	
	
	/// 默认信任服务器证书
	func webView(_ webView: WKWebView,
	             didReceive challenge: URLAuthenticationChallenge,
	             completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
		
		let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
		
		completionHandler(.useCredential, credential)
		
	}
}


