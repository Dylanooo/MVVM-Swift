//
//  MicrophoneView.swift
//  SwiftMVVM
//
//  Created by Dylan.Lee on 2017/12/18.
//  Copyright © 2017年 Dylan.Lee. All rights reserved.
//

import UIKit

class MicrophoneView: UIButton {

    init(voiceTime: String) {
        super.init(frame: CGRect.zero)
        setupUI(time: voiceTime)
    }
    
    func setupUI(time: String) {
        let imgView = UIImageView(image: UIImage(named: "icon_article_voice"))
        addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.width.equalTo(21.5)
            make.height.equalTo(24)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
        }
        
        let timeLabel = UILabel()
        timeLabel.textColor = .white
        timeLabel.text = time
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(imgView.right).offset(16)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
