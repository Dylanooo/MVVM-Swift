//
//  UIWebViewController.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/9/12.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//
//	----------------------------------------------------------------------------
//
//  UIWebView
//	优点:
//    1.各项功能稳定，除性能缺陷外，基本不会出现各种奇葩问题
//	  2.Cookie在整个App中共享，并且操作简单
//    3.可做本地缓存
//  缺点:
//    1.性能十分糟糕，同样的页面，相较WKWebView而言，内存、CPU与电量消耗较巨大
//    2.UI层的可操作性十分有限



import UIKit

extension WebViewController: UIWebViewDelegate {
	
	/// 设置UIWebView
	func setupUIWebView() {
		let kWebView = UIWebView()
		kWebView.translatesAutoresizingMaskIntoConstraints = false
		kWebView.scrollView.clipsToBounds = true
		kWebView.scrollView.bounces = false
		kWebView.scrollView.keyboardDismissMode = .onDrag
		kWebView.scrollView.backgroundColor = .white
		kWebView.scalesPageToFit = true
		kWebView.allowsInlineMediaPlayback = true
		kWebView.mediaPlaybackRequiresUserAction = false
		kWebView.delegate = self
		webView = kWebView
	}
}
