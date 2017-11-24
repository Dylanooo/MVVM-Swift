//
//  UserViewModel.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/13.
//  Copyright © 2017年 Autohome.Inc. All rights reserved.
//

import UIKit

class BaseViewModel<Services: Request> where Services.EntityType: DBModel {
	let provider = HTTPApi<Services>()
	init() {
	}
}
