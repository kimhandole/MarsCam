//
//  UIFont.swift
//  MarsPhotoCatcher
//
//  Created by Handole Kim on 2/23/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
import UIKit

private struct Default {
    static let font = UIFont.systemFont(ofSize: 16)
}

extension UIFont {
    
    public class var Regular: UIFont {
        return UIFont(name: "PingFangTC-Regular", size: 16) ?? Default.font
    }
    public class var Semibold: UIFont {
        return UIFont(name: "PingFangTC-Semibold", size: 16) ?? Default.font
    }
    public class var Title: UIFont {
        return UIFont(name: "PingFangTC-Semibold", size: 24) ?? Default.font
    }
}
