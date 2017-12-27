//
//  AHTabBar.swift
//  Dylan.Lee
//
//  Created by Dylan on 2017/11/16.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class AHTabBar: UITabBar {
	
	private var centerBtn: UIButton!
	var centerBtnClickedClosure: (()->Void)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		let bgImgView = drawTabBarBgImageView()
		self.insertSubview(bgImgView, at: 0)
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
		
	}
	
	func drawTabBarBgImageView() -> UIImageView {
		
		let radius: CGFloat = 28
		let standOutHeight: CGFloat = 20
		let tabBarHeight: CGFloat = self.height
		let allFloat: CGFloat = pow(radius, 2) - pow(radius - standOutHeight, 2)
		let ww: CGFloat = CGFloat(sqrtf(Float(allFloat)))
		let imageView = UIImageView(frame: CGRect(x: CGFloat(0.0), y: 0, width: kScreenWidth, height: tabBarHeight))
		let size = imageView.size
		let layer = CAShapeLayer()
		let path = UIBezierPath()
		path.move(to: CGPoint(x: size.width/2 - ww, y: 0))
		
		let angleH = ((radius - ww)/radius)
		
		let startAngle = (1 + angleH) * CGFloat(Double.pi)
		let endAngle = (2 - angleH) * Float(Double.pi)
		
		path.addArc(withCenter: CGPoint(x: size.width/2, y: radius - standOutHeight), radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
		path.addLine(to: CGPoint(x: size.width/2 + ww, y: 0))
		path.addLine(to: CGPoint(x: size.width, y: 0))
		path.addLine(to: CGPoint(x: size.width, y: size.height))
		path.addLine(to: CGPoint(x: 0, y: size.height))
		path.addLine(to: CGPoint(x: 0, y: 0))
		path.addLine(to: CGPoint(x: size.width/2 - ww, y: 0))
		
		layer.path = path.cgPath
		layer.fillColor = UIColor.white.cgColor
		layer.lineWidth = 1/UIScreen.main.scale
		imageView.layer.addSublayer(layer)
		
		centerBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
		centerBtn.addTarget(self, action: #selector(centerBtnClicked), for: .touchUpInside)
		centerBtn.setImage(UIImage(named: "icon_nav_close_white"), for: .normal)
		centerBtn.layer.cornerRadius = centerBtn.width/2
		centerBtn.layer.masksToBounds = true
		centerBtn.backgroundColor = UIColor(hexColor: "#49afcd")
		centerBtn.center = CGPoint(x: imageView.width/2, y: imageView.height/2 - 18)
		
		imageView.clipsToBounds = false
		imageView.isUserInteractionEnabled = false
		imageView.addSubview(centerBtn)
		imageView.layer.shadowOpacity = 0.1
		imageView.layer.shadowRadius = 1/UIScreen.main.scale
		imageView.layer.shadowColor = UIColor.black.cgColor
		imageView.layer.shadowOffset = CGSize(width: 0, height: -1/UIScreen.main.scale)
		return imageView
	}
	
	@objc func centerBtnClicked() {
		
		guard let clickBlock = centerBtnClickedClosure else {
			
			return
		}
		
		clickBlock()
		DebugPrint("点击事件")
	}
	
	override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		
        /// 防止在其他页面也相应点击中间按钮事件
        if !self.isHidden {
            var view = super.hitTest(point, with: event)
   
            if view == nil {
                let newPoint = centerBtn.convert(point, from: self)
                if centerBtn.bounds.contains(newPoint) {
                    view = centerBtn
                }
            }
            return view
        } else {
            return super.hitTest(point, with: event)
        }
		
	}
}
