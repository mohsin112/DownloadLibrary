//
//  JSONObject.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class JSONObject: NSObject {

    var lastUsedDate:TimeInterval = 0
    var nameOfJSON:String = ""
    var jsonString:String = "[]"
    

    init(jsonString:String,name:String)
    {
        super.init()
        let actualName = name.replacingOccurrences(of: "/", with: "")
        self.jsonString = jsonString
        self.nameOfJSON = actualName
        self.lastUsedDate = Date().timeIntervalSinceNow
    }
}
