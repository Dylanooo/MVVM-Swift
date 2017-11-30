![Mac OS X](https://img.shields.io/badge/os-Mac%20OS%20X-green.svg?style=flat)
![MVVM](https://img.shields.io/badge/Design Pattern-MVVM-4BC51D.svg?style=flat)
![Swift 4 compatible](https://img.shields.io/badge/swift4-compatible-4BC51D.svg?style=flat)
![MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)

# MVVM-Swift
基于Swift 4.0的MVVM框架，仿照Moya对Alamofire进行更轻量级的封装，网络请求返回实体或者实体数组，结构更清晰

## 项目结构
* Controllers
* ViewModels
* Views
* Utils
	* Extension
		* UIColorExtension
		* NSObjectExtension
		* NotificationCenterExtension
		* UIApplicationExtension
		* NSUserDefaultsExtension
		* UIViewControllerExtension
		* UIStoryboardExtension
		* UIViewExtension
		* StringExtension
		* UIImageExtension
		* FoundationExtension 
	* Configure
	* ThirdPart
	* Custom
		* Managers
		> * NetworkManager（仿照Moya的轻量级实现）
		> * CacheManager (待实现)
		> * AppManager
		> * ThemeManager
		> * DateManager
		> * FileManager
		> * LocationManager
		> * DBManager(基于RealmSwift)
		
		* UITools
		> * CustomProgressHUD
		> * WebView(UIWebView&WKWebView)
* Resources
	* Interface
	* Assets.xcassets
	* Images
	* Documents

## 架构工作流程
![流程图](http://7xoyls.com1.z0.glb.clouddn.com/mvvmflow.png)

### Utils中部分工具介绍

#### NetworkManager
*  Model 中实现方式，遵循RealmSwift的写法

```
import UIKit
import RealmSwift

class Province: DBModel {
	
	@objc dynamic var id: Int = 0
	
	@objc dynamic var firstletter: String = ""
	
	@objc dynamic var name: String = ""


	/// 设置与Contry的一对多关系
	let owner = LinkingObjects(fromType: Country.self, property: "provinces")


	/// 设置与cities的一对多关系， 保持字段名称与服务端返回一致
	let citys = List<City>()
	
}

```

* API 中实现如下：

```
enum UserApi {
	case login
	case Image(count:Int,page:Int)
	case regester
	case xxx
	case download
}

extension UserApi: Request {


	/// 请求返回实体类型
	typealias EntityType = Country


	/// host 如果项目中所有host可以保持一致，直接在Request中设置默认Host，在具体的Api中可省略
	var baseURL: String {
		
		switch self {
			
		case .xxx:
			
			return "http://www.baidu.com"
			
		default:
			
			return "http://comm.app.autohome.com.cn"
			
		}
	}


	/// 具体业务对应的path
	var path: String {
		
		switch self {
			
		case .login:
			
			return "/news/province-pm2-ts0.json"
			
		case .regester:
			
			return "/regester"
			
		case .download:
			
			return "http://7xoyls.com1.z0.glb.clouddn.com/%E9%99%88%E5%A5%95%E8%BF%85-%E4%B8%80%E4%B8%9D%E4%B8%8D%E6%8C%82%20%28Live%29.mp3"
			
		default:
			
			return ""
			
		}
	}
	
	/// 参数
	var parameters: [String: Any]? {
		
		switch self {
			
		case .Image(let X, let Y):
			
			return ["x": X, "y": Y]
			
		default:
			
			return [:]
			
		}
	}
}

```

* ViewModel 中实现：

```
import UIKit

class UserViewModel: BaseViewModel<UserApi> {
	
	func login(pwd: String?, account: String?, complete: @escaping ((Country)->Void)) {
		
		provider.request(.login, responseHandler: { response in
			
			DebugPrint("value = \(String(describing: response.value))")
			
			DebugPrint("values = \(String(describing: response.values))")
			
			DebugPrint(response.message)
			
			if let province = response.value {
				
				complete(province)
				
			}
			
		})
	}
}
```


