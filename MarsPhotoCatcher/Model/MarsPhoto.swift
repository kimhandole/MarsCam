//
//  MarsPhoto.swift
//  MarsPhotoCatcher
//
//  Created by Handole Kim on 2/23/19.
//  Copyright © 2019 Han Dole Kim. All rights reserved.
//
import UIKit

class MarsPhoto: NSObject {
    var id: Int
    var cameraName: String
    var imageSource: String
    
    init(id: Int, cameraName: String, imageSource: String) {
        self.id = id
        self.cameraName = cameraName
        self.imageSource = imageSource
    }
}
