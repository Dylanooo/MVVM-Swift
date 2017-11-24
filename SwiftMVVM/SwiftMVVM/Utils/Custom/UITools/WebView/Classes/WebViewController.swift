//
//  WebViewController.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/9/12.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//
//	----------------------------------------------------------------------------
//
//	★ 可根据具体情况选定使用UIWebView/WKWebView
//  ★ 具体优缺点在相应的扩展类中有介绍

import UIKit
import WebKit
import SnapKit

class WebViewController: UIViewController {
	
	// MARK: 声明
	/// -网页视图
	var webView: UIView!
	
	/// -是否使用UIWebView
	private var useUIWebView: Bool = false
	var needCache: Bool = false
	
	/// 网页的URL
	private var webURL: String! = ""
	
	
	/// 初始化函数
	///
	/// - Parameters:
	///   - url: 需要加载的URL
	///   - needCache: 是否需要清除缓存
	convenience init(_ url: String, needCache shouldCache: Bool) {
		self.init()
		needCache = shouldCache
		webURL = url
		
	}
	
	
	// MARK: OverWirte
    override func viewDidLoad() {
		
		super.viewDidLoad()

		setupWebView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	/// *****外部方法*****
	
	/// 加载url网页
	///
	/// - Parameter url: 网页url
	open func load(_ url: String) {
		webURL = url
		let requestURL = URL(string: url)
		
		if requestURL == nil {
			webViewLoadHTMLString("<p style='color: red'>资源链接有误, 请稍后再试</p>")
			return
		}
		
		let request = URLRequest(url: requestURL!,
		                         cachePolicy: .reloadIgnoringLocalCacheData,
		                         timeoutInterval: 30)
		
		if webView is WKWebView {
			
			(webView as! WKWebView).load(request)
			
		} else {
			
			(webView as! UIWebView).loadRequest(request)
		}
	}
	
	
	/// 加载本地HTML文件
	///
	/// - Parameter fileName: 文件名称
	open func loadLocalHTMLFile(_ fileName: String) {
		webViewLoadHTMLString(readHTMLFromLocalFile(fileName))
	}


	//******** 私有方法 *********
	
	// MARK: UI部分
	/// 设置WebView
	private func setupWebView() {
		
		if useUIWebView {
			
			setupUIWebView()
			
		} else {
			
			setupWKWebView()
			
		}
		
		view.addSubview(webView)
		
		setupWebViewConstraints()
	}
	
	/// 为WebView设置约束
	private func setupWebViewConstraints() {
		
		webView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}
	
	// MARK: 数据部分
	
	/// 网页加载HTML
	///
	/// - Parameter html: HTML文本
	private func webViewLoadHTMLString(_ html: String) {
		
		let lazyInfo = changeHTMLStringToLazyLoadDocument(html: html)
		
		if webView is WKWebView {
			
			(webView as! WKWebView).loadHTMLString(lazyInfo.handledHTML, baseURL: lazyInfo.baseURL)
			
		} else {
			
			(webView as! UIWebView).loadHTMLString(lazyInfo.handledHTML, baseURL: lazyInfo.baseURL)
		}
	}
	
	
	/// 从本地文件读取HTML文本
	///
	/// - Parameter name: HTML文件名称
	/// - Returns: HTML文本
	private func readHTMLFromLocalFile(_ name: String) -> String {
		
		let localPath = Bundle.main.path(forResource: name, ofType: nil)
		
		let html = try! String(contentsOfFile: localPath!, encoding: .utf8)
		
		return html
		
	}
	
	
	/// 对HTML文本做懒加载处理
	///
	/// - Parameter html: 需要加载的文本
	/// - Returns:  baseURL-本地html、js等资源文本的目录   handledHTML-处理后的文本
	private func changeHTMLStringToLazyLoadDocument(html: String) -> (baseURL: URL, handledHTML: String) {
		
		/// - 标签替换
		let originalStr = html.replacingOccurrences(of: "src", with: "data-original")
		
		/// - 获取本地HTML文本路径
		let lazySourcePath = Bundle.main.path(forResource: "lazyload", ofType: "html")
		
		
		/// - 加载html文件内容
		var lazyHTML = try! String(contentsOfFile: lazySourcePath!, encoding: .utf8)
		
		/// - 替换temp内的占位符{{Content_holder}}为需要加载的HTML代码
		lazyHTML = lazyHTML.replacingOccurrences(of: "{{Content_holder}}", with: originalStr)
		
		let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
		
		return(baseURL, lazyHTML)
		
	}
}













