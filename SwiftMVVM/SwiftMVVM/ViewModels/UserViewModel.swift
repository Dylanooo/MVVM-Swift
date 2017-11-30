//
//  UserViewModel.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/13.
//  Copyright © 2017年 Autohome.Inc. All rights reserved.
//

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
	
	deinit {
		DebugPrint("ViewModel deinit~~~~")
	}
}


