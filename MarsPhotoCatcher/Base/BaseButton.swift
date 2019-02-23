//
//  BaseButton.swift
//  MarsPhotoCatcher
//
//  Created by Handole Kim on 2/23/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
import UIKit

class BaseButton: UIButton {
    
    init(title: String?="", titleColor: UIColor, backgroundColor: UIColor, font: UIFont) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = font
        self.layer.cornerRadius = 6
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
