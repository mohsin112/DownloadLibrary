//
//  ImageObject.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class ImageObject: NSObject {

    var lastUsedDate:TimeInterval = 0
    var nameOfImage:String = ""
    var image:UIImage = UIImage()
    

    init(image:UIImage,name:String)
    {
        super.init()
        let actualName = name.replacingOccurrences(of: "/", with: "")
        self.image = image
        self.nameOfImage = actualName
        self.lastUsedDate = Date().timeIntervalSinceNow
    }
}
