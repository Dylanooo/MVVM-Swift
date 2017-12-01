//
//  UserViewModel.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/13.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class BaseViewModel<Services: Request> where Services.EntityType: DBModel {
	
	let provider = HTTPProvider<Services>()
	
}
