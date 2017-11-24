//
//  LocationManager.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/25.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

public enum LocationServiceStatus: Int {
	
	case available
	
	case undetermined
	
	case denied
	
	case restricted
	
	case disabled
	
}

public typealias UserCLLocation = ((_ location: CLLocation) -> Void)

public typealias CityString = ((_ city: String? ) -> Void)

private let DistanceAndSpeedCalculationInterval = 5.0;

private let LocationManagerSingleton = LocationManager()

public class LocationManager: NSObject, CLLocationManagerDelegate {
	
	//Creat a singleton
	public class var sharedInstance: LocationManager {
		
		return LocationManagerSingleton
		
	}
	public var userLocation: CLLocation?
	
	//define block var
	private var onUserCLLocation: UserCLLocation?
	
	private var onCityString: CityString?
	
	//last location date
	public var LastDistanceAndSpeedCalculation: Double = 0
	
	//current device location author status
	class var status: LocationServiceStatus {
		
		if !CLLocationManager.locationServicesEnabled() {
			
			/// go to setting
			return .disabled
			
		} else {
			
			switch CLLocationManager.authorizationStatus() {
			
			/// have not did choice
			case .notDetermined:
				
				return .undetermined
			/// user denied
			case .denied:
				
				return .denied
			/// application refuse location
			case .restricted:
				
				return .restricted
			/// location available
			case .authorizedAlways, .authorizedWhenInUse:
				
				return .available
			}
			
		}
	}
	
	
	// creat an CLLocationManager instance
	private var locationManager: CLLocationManager!
	
	// initlize CLLocationManager
	override init() {
		
		super.init()
		
		locationManager = CLLocationManager()
		
		// set the best accuracy
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		
		// when the loaction has changed over 100 metre
		locationManager.distanceFilter = 100
		
		if CLLocationManager.authorizationStatus() == .notDetermined {
			
			locationManager.requestWhenInUseAuthorization()
			
		}
		
		locationManager.delegate = self
		
		startLocation()
		
	}
	
	// begin locate
	public func startLocation()  {
		

		locationManager.startUpdatingLocation()
		
	}
	
	// end locate
	public func stopLocation()  {
		
		locationManager.stopUpdatingLocation()
		
	}
	
	//MARK:- locationManager Delegate
	public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		
		DebugPrint("定位发生异常:\(error.localizedDescription)")
		
	}
	
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		guard locations.count > 0 else {
			
			return
			
		}
		
		// to rule out the continuous loacte
		if LastDistanceAndSpeedCalculation > 0 {
			
			guard NSDate.timeIntervalSinceReferenceDate - LastDistanceAndSpeedCalculation  > DistanceAndSpeedCalculationInterval else {
				
				return;
			}
		}
		
		LastDistanceAndSpeedCalculation = NSDate.timeIntervalSinceReferenceDate
		
		let location: CLLocation? = CLLocation(latitude: locations.last!.coordinate.latitude, longitude: locations.last!.coordinate.longitude)
		
		DebugPrint(location?.coordinate.latitude ?? 111)
		
	
		DebugPrint(location?.coordinate.longitude ?? 222)
		
		userLocation = location
		
		onUserCLLocation!(userLocation!)
		
		reverseGeocode(currLocation: location)
		
	}
	
	
	func reverseGeocode(currLocation: CLLocation!) {
		
		let geocoder = CLGeocoder()
		
		var placemark: CLPlacemark?
		
		geocoder.reverseGeocodeLocation(currLocation, completionHandler: { (placemarks, error) -> Void in
			
			if error != nil {
				
				DebugPrint("reverse geodcode fail: \(error!.localizedDescription)")
				
				return
				
			}
			
			let pm = placemarks! as [CLPlacemark]
			
			if (pm.count > 0) {
				
				placemark = placemarks![0]
				
				let city: String = placemark!.locality! as String
				
				self.onCityString!(city)
				
				DebugPrint(city)
				
				self.stopLocation()
				
			} else {
				
				DebugPrint("No Placemarks!")
				
			}
		})
	}
	
	// get latitude and longitude
	func getUserLocationInfo(cllocation: @escaping UserCLLocation, city: @escaping CityString) -> Void {
		
//		showGoSetting()
		
		startLocation()
		
		onUserCLLocation = cllocation;
		
		onCityString = city;
	}
	
	// get latitude and longitude
	func getUserCCLocation(cllocation: @escaping UserCLLocation) -> Void {
		
//		showGoSetting()
		
		startLocation()
		
		onUserCLLocation = cllocation;
	}
	
	
	func showGoSetting() {
		
//		if LocationManager.status != .available {
//
//			let alertView = UIAlertView(title: "提示",
//			                            message: "您未开启定位服务，是否开启？",
//			                            delegate:  self,
//			                            cancelButtonTitle: "取消",
//			                            otherButtonTitles: "去开启")
//
//			alertView.show()
//
//		}

	}
}

extension LocationManager: UIAlertViewDelegate {
	
//	public func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
//
//		if buttonIndex == 0 {
//
//			DebugPrint("点击第0个")
//
//		} else {
	
//			let settingUrl = URL(string: UIApplicationOpenSettingsURLString)
//
//			if UIApplication.shared.canOpenURL(settingUrl!) {
//
//				UIApplication.shared.openURL(settingUrl!)
//
//			}
//
//			DebugPrint("点击第一个")
//		}
//	}
}
