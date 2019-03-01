//
//  BaseLabel.swift
//  MarsPhotoCatcher
//
//  Created by Han Dole Kim on 2/23/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
import UIKit

class BaseLabel: UILabel {
    
    init(text: String?="", font: UIFont, textAlignment: NSTextAlignment, textColor: UIColor, numberOfLines: Int, breakMode: NSLineBreakMode? = nil) {
        super.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.isUserInteractionEnabled = false
        if let breakMode = breakMode { self.lineBreakMode = breakMode }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
