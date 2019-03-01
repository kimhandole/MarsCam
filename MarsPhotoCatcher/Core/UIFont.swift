//
//  UIFont.swift
//  MarsPhotoCatcher
//
//  Created by Han Dole Kim on 2/23/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
import UIKit

private struct Default {
    static let font = UIFont.systemFont(ofSize: 16)
}

extension UIFont {
    
    public class var Footnote: UIFont {
        return UIFont(name: "PingFangTC-Regular", size: 13) ?? Default.font
    }
    public class var Regular: UIFont {
        return UIFont(name: "PingFangTC-Semibold", size: 17) ?? Default.font
    }
    public class var Title: UIFont {
        return UIFont(name: "PingFangTC-Semibold", size: 20) ?? Default.font
    }
}
