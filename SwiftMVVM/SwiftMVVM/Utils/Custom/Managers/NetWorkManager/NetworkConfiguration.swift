//
//  NetworkConfiguration.swift
//  MVVMFrameWork
//
//  Created by Dylan on 16/5/10.
//  Copyright © 2016年 Dylan.Lee. All rights reserved.
//  网络请求基本配置（使用前请修改相关配置）

//  TODO: 网络请求配置(使用时根据需要增加、修改)
struct NetworkConfig {
  
  /// ***********网络请求基本配置*************
  /// 路径
  static let kBaseURL = "http://mall.autohome.com.cn"
  /// 域名
  static let kDomain  = "com.mvvm-swift.framework"
  /// 缓存路径
  static let kCachePath = "MyApp.Cache"
  /// 可接收类型
  static let kContentType: Set<String> = ["application/json",
                                          "text/html",
                                          "text/javascript",
                                          "image/jpeg",
                                          "application/x-zip-compressed"]
  
  
  /// ************返回数据正常时的键************
  /// 状态码
  static let kRetCode = "returncode"
  /// 描述信息
  static let kRetMsg  = "message"
  /// 返回数据
  static let kRetData = "result"
  
  
  /// *************返回数据类型异常*************
  /// 异常信息
  static let kErrorMsg = "返回数据格式异常"
  /// 异常码
  public static let kErrorCode = 300
	
  /// *************返回数据成功*************
  public static let kSuccessMsg = "请求成功"
  
}
