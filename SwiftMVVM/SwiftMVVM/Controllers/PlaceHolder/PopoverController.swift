//
//  PopoverController.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/7/25.
//  Copyright © 2017年 SowMe.Inc. All rights reserved.
//

import UIKit
import AVFoundation
import Kingfisher
class PopoverController: UIViewController {

	var progressView: UIProgressView!
		
	@IBOutlet weak var handleBtn: UIButton!

    // MARK: Override Methods
	override func viewDidLoad() {
		
        super.viewDidLoad()
        
		handleBtn.layer.cornerRadius = handleBtn.width/2
		handleBtn.addTarget(self, action: #selector(play), for: .touchUpInside)
    }
	
	override func viewWillAppear(_ animated: Bool) {
		
		super.viewWillAppear(animated)
		
		UIView.animate(withDuration: 0.3, animations: {
		
			let transform = CGAffineTransform(rotationAngle: 55 * .pi/180.0)
			self.handleBtn.transform = transform

		}, completion: { finish in
			
			UIView.animate(withDuration: 0.2, animations: {
			
				let transform = CGAffineTransform(rotationAngle: 45 * .pi/180.0)
				self.handleBtn.transform = transform
				
			})
			
		})

	}
	
	
	// MARK: Action Methods
	@objc func play() {
		
		UIView.animate(withDuration: 0.3, animations: {
			
			let transform = CGAffineTransform(rotationAngle: 0)
			self.handleBtn.transform = transform
			
		}, completion: { finish in
			
			self.dismiss(animated: true, completion: nil)
			
		})
		

	}
    
	
    override func didReceiveMemoryWarning() {
		
        super.didReceiveMemoryWarning()
		
    }

}
