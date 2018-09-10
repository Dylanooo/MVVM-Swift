![Mac OS X](https://img.shields.io/badge/os-Mac%20OS%20X-green.svg?style=flat)
![MVVM](https://img.shields.io/badge/Design%20Pattern-MVVM-4BC51D.svg?style=flat)
![Swift 4 compatible](https://img.shields.io/badge/swift4-compatible-4BC51D.svg?style=flat)
![MIT](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)

# MVVM-Swift
* 基于`Swift 4.0`的`MVVM`框架
* 仿照`Moya`对`Alamofire`进行更轻量级的封装,网络请求返回实体或者实体数组（双刃剑，缺点在于对于简单数据结构也需要创建相应的实体对象，优点是保持项目结构统一，后续会优化）
* 基于当下流行的`Realm`数据库，封装了一套方便开发者，对数据库`CRUD`操作的数据库工具类
* 另外通过灵活使用`Swift`的语言特性，封装了其他更方便的工具类，使开发者的工作更轻松

#### Tips: 因为项目涉及的功能较多，部分功能测试不够充分，如果有不合理的地方，请多多指教，后续我也将不断完善这个框架，努力打造一套合理、简洁、实用的项目

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

#### 一、 NetworkManager
*  `Model` 中实现方式，遵循`RealmSwift`的写法

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

* `API` 中实现如下：

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

* `ViewModel` 中实现：

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

### 二、 NotifcationCenterExtension
通过对`NotificationCenter`封装后，开发者在定义通知名称的时候，只需要在枚举`NotificationName` 中添加对应的`case`就可以了，方便简单

```
enum NotificationName: String {

	// 用户登录成功
	case loginSuccess

	// 用户退出登录
	case logout

}

```

调用时代码可以更加简洁了， 而且可以和调用系统通知格式保持一致：

```
    // 调用自定义的通知名称
    NotificationCenter.post(name: .loginSuccess, object: nil, userInfo: nil)

    // 调用系统的通知名称
    NotificationCenter.post(name: .UIKeyboardDidHide, object: nil, userInfo: nil)

```

**PS:项目中所用服务端接口为本地服务,实现方式为Python+Flask+MongoDB，如有需要，请部署项目[MVVM-Service](https://github.com/Dylanooo/MVVM-Service)**


