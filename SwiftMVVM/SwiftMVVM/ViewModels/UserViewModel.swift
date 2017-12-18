//
//  UserViewModel.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/13.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class UserViewModel: BaseViewModel<UserApi> {
	
    func login(pwd: String, account: String, complete: @escaping ((User?)->Void)) {

        
        provider.request(.login(mobile: account, passwd: pwd), responseHandler: { response in

            DebugPrint("value = \(String(describing: response.value))")

            DebugPrint("values = \(String(describing: response.values))")

            if response.success {
                if response.code == 0 {
                    complete(response.value!)
                } else {
                    complete(nil)
                }
                
            } else {
                
                complete(nil)
                
            }
        })
    }
    
    func register(pwd: String, account: String, complete: @escaping ((User?)->Void)) {
        
        
        provider.request(.register(mobile: account, passwd: pwd), responseHandler: { response in
            
            DebugPrint("value = \(String(describing: response.value))")
            
            DebugPrint("values = \(String(describing: response.values))")
            
            if response.success {
               
            }
            
            if response.success {
                complete(response.value!)
                
            } else {
                
                complete(nil)
                
            }
        })
    }
}


