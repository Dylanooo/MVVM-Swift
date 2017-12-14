//
//  NetworkManager.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/8/15.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class NetworkManager {
	
	
	/// 网络工具实例
	static let sharedInstance = NetworkManager()
	
	/// SessionManager 实例
	private var sessionManager: SessionManager = {

		/// set up URLSessiong configure
		let configuration = URLSessionConfiguration.default
		
		configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
		
		configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
		
		configuration.timeoutIntervalForRequest = 30
		
		let sm = Alamofire.SessionManager(configuration: configuration)
		
		// Ignore SSL Challenge
		sm.delegate.sessionDidReceiveChallenge = { session, challenge in
			
			var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
			
			var credential: URLCredential?
			
			if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
				
				disposition = URLSession.AuthChallengeDisposition.useCredential
				
				credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
				
			} else {
				
				if challenge.previousFailureCount > 0 {
					
					disposition = .cancelAuthenticationChallenge
					
				} else {
					
					credential = sm.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
					
					if credential != nil {
						
						disposition = .useCredential
						
					}
				}
			}
			
			return (disposition, credential)
		}
		
		return sm
	}()
	
	/// 网络请求
	///
	/// - Parameters:
	///   - targetType: 请求数据模型
	///   - response: 请求相应
    func request<T: Request>(_ targetType: T, responseHandler: @escaping ResponseBlock<T.EntityType>)  where T.EntityType: DBModel {
		
		var url: URL!
		
		if targetType.path.contains("https") || targetType.path.contains("http") {
			
			url = URL(string: targetType.path)!
			
		} else {
			
			url = URL(string: targetType.baseURL.appending(targetType.path))!
			
		}
		
		sessionManager.request(url,
		                       
		                       method: targetType.method,
		                       
		                       parameters: targetType.parameters,
		                       
		                       encoding: URLEncoding.default,
		                       
		                       headers: nil)
			
			.validate(contentType: NetworkConfig.kContentType)
			
			.validate(statusCode: 200..<400)
			
			.responseJSON(completionHandler: {[weak self] response in
				
				self?.handleResult(response, handler: responseHandler)
				
			})
	}

	
	/// 下载文件
	///
	/// - Parameters:
	///   - targetType: 下载对象模型
	///   - destinationPath: 存储路径 默认在沙盒Document下
	///   - response: 请求相应
	/// - Returns: 下载请求
	func download<T: Request>(_ targetType: T, destinationPath: String = "",response: ResponseBlock<T.EntityType>) -> Alamofire.DownloadRequest where T.EntityType: DBModel {
		
		var url: URL!
		
		if targetType.path.contains("https") || targetType.path.contains("http") {
			
			url = URL(string: targetType.path)!
			
		} else {
			
			url = URL(string: targetType.baseURL.appending(targetType.path))!
			
		}
		
		var destPath: URL
		
		if destinationPath.count == 0 {
				
			let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
			
			destPath = directoryURLs[0].appendingPathComponent("/Music/")

		} else {
			
			destPath = URL(string: destinationPath)!
			
		}
		
		
		let destination: Alamofire.DownloadRequest.DownloadFileDestination = { temporaryURL, response in
			
			return (destPath.appendingPathComponent("\(url.lastPathComponent.urlDecoded())"), [.createIntermediateDirectories])
		}
		
		return sessionManager.download(URLRequest(url: url), to: destination).response(completionHandler: { response in
			
		})
		
	}
	
    
    func upload<T: Request>(_ targetType: T, responseHandler: @escaping ResponseBlock<T.EntityType>) where T.EntityType: DBModel {
        assert(targetType.files != nil, "上传文件不能为空")
        var url: URL!
        
        if targetType.path.contains("https") || targetType.path.contains("http") {
            
            url = URL(string: targetType.path)!
            
        } else {
            
            url = URL(string: targetType.baseURL.appending(targetType.path))!
            
        }

        sessionManager.upload(multipartFormData: { multiData in
            guard let files = targetType.files else {
                return;
            }
            
            if let parameters = targetType.parameters {
                
                for (key, value) in  parameters {
            
                    let data = JSON(value)
                    
                    let dataStr = data.string
                    
                    multiData.append((dataStr?.data(using: .utf8))!, withName: key)
                }
            }
            
            
            for file in files {
                
                if file.uploadType == .data {
                    multiData.append(file.data, withName: "file", fileName: file.name, mimeType: file.mimeType)
                } else {
                    multiData.append(URL(string: file.filePath)!, withName: file.name, fileName: file.name + file.mimeType, mimeType: file.mimeType)
                }
            }
            
        }, to: url) { [weak self] encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                
                upload.responseJSON { response in
                    self?.handleResult(response, handler: responseHandler)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
	
	
	/// 处理返回数据
	///
	/// - Parameters:
	///   - response: resonse实例
	///   - responseHandler: 处理后回调
	func handleResult<T: DBModel>(_ response: DataResponse<Any>, handler responseHandler: @escaping ResponseBlock<T>) {
		
		
		switch response.result.isSuccess {
			
			case true:
				
				if let value = response.result.value {
					
					let responseObj = JSON(value)
					
					/// 与服务端约定数据格式
					if let respDic = responseObj.dictionary {

						let code = NetWorkRetCode(respDic)

						let msg = NetworkRetMsg(respDic)

						let data = NetworkRetData(respDic)

                        if let resultDatas = data.arrayObject {
                            
                            var models = [T]()
                            
                            for modelDic in resultDatas {
                                models.append(T(value: modelDic))
                            }
                            
                            let result = Result(value: nil, code: code, values: models, message: Message.responseMsg(msg).retMsg())
                            
                            let customResult = Response<T>.Success(result)
                            
                            responseHandler(customResult)
                            
                        } else if let resultData = data.dictionaryObject {
                            
                            let model = T(value: resultData)
                            
                            let result = Result(value: model, code: code, values: nil, message: Message.responseMsg(msg).retMsg())
                            
                            let customResult = Response<T>.Success(result)
                            
                            responseHandler(customResult)

                            
                        } else {
                            DebugPrint("❌❌❌❌==数据结构异常==❌❌❌❌")
                            
                            let error = NetError(code: code, message: msg)
                            
                            let customResult = Response<T>.Failure(error)
                            
                            responseHandler(customResult)
                            
                            
                        }


					} else if let respArr = responseObj.arrayObject { /// 直接返回数组
						
						var resultObjs = [T]()
						
						for item in respArr {
							
							resultObjs.append(T(value: item))
							
						}

						let result = Result<T>(value: nil, code: 0 , values: resultObjs, message: Message.success.retMsg())

						let customResult = Response<T>.Success(result)

						responseHandler(customResult)

					} else { /// 直接返回字符串

						let responseStr = String(data: response.data!, encoding: .utf8)

						let result = Result<T>(value: T(value: responseStr ?? ""), code: 0, values: [T(value: responseStr ?? "")], message: Message.success.retMsg())

						let customResult = Response.Success(result)

						responseHandler(customResult)

					}
			}
			
		case false:
			
			DebugPrint("❌❌❌❌==请求错误==❌❌❌❌")
			
			handleError(error: response.error, completeHandler: responseHandler)

		}
	}
	
	
	/// 处理错误
	///
	/// - Parameters:
	///   - error: 错误
	///   - completeHandler: 处理回调
	func handleError<T>(error: Error?, completeHandler:  ResponseBlock<T>) {
		
		var errMsg: String!
		
		var errorCode = -999
		
		if let error = error as? AFError {
			
			switch error {
				
			case .invalidURL(let url):
				
				errMsg = "无效的请求"
				
				DebugPrint("无效 URL: \(url) - \(error.localizedDescription)")
				
			case .parameterEncodingFailed(let reason):
				
				errMsg = "参数编码失败"
				
				DebugPrint("失败理由: \(reason)")
				
			case .multipartEncodingFailed(let reason):
				
				errMsg = "参数编码失败"
				
				DebugPrint("失败理由: \(reason)")
				
			case .responseValidationFailed(let reason):
				
				DebugPrint("Response 校验失败: \(error.localizedDescription)")
				
				DebugPrint("失败理由: \(reason)")
				
				switch reason {
					
				case .dataFileNil, .dataFileReadFailed:
					
					errMsg = "文件不存在"
					
					DebugPrint("无法读取下载文件")
					
				case .missingContentType(let acceptableContentTypes):
					
					errMsg = "文件类型不明"
					
					DebugPrint("文件类型不明: \(acceptableContentTypes)")
					
				case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
					
					errMsg = "文件无法读取"
					
					DebugPrint("文件类型: \(responseContentType) 无法读取: \(acceptableContentTypes)")
					
				case .unacceptableStatusCode(let code):
					
					errMsg = "请求被拒绝"
					
					errorCode = code
					
					DebugPrint("请求失败: \(code)")
					
				}
				
			case .responseSerializationFailed(let reason):
				
				errMsg = "请求返回内容解析失败"
				
				DebugPrint("失败理由: \(reason)")
				
			}
			
			DebugPrint("错误: \(String(describing: error.underlyingError))")
			
		} else if let error = error as? URLError {
			
			errMsg = "网络异常，请检查网络"
			
			errorCode = error.code.rawValue
			
			DebugPrint("网络异常，请检查网络: \(error)")
			
		} else {
			
			let nsError = (error! as NSError)
			
			errorCode = nsError.code
			
			errMsg = nsError.description
			
		}
		
		let error = NetError(code: errorCode, message: errMsg)
		
		let customResult = Response<T>.Failure(error)
		
		completeHandler(customResult)

	}
	
}
