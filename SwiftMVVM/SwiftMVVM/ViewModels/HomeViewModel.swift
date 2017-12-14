//
//  HomeViewModel.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/15.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
	
	/// 开始定位
	func setupLoaction() {
		
		LocationManager.sharedInstance.getUserLocationInfo(cllocation: { location in
			
//            print("lat = \(location.coordinate.latitude)  lon = \(location.coordinate.longitude)")
			
		}, city: { city in
			
//            print(city ?? "mm")
			
		})
	}
	
	func login(account: String, pwd: String, complete: ((String, String) -> Void)) {
		
//        let UserProvider = HTTPProvider<UserApi>()
		
	}
}
