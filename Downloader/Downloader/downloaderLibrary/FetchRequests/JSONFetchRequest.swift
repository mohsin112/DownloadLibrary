//
//  JSONFetchRequest.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class JSONFetchRequest: NSObject {
    
    fileprivate var callBackBlock: (String)->Void
    var urlStr:String = ""
    var completionBlock: (String)->Void
    {
        set
        {
           callBackBlock = newValue
        }
        get
        {
            return callBackBlock
        }
    }
    
    override init() {
        self.callBackBlock = {i in return } // empty block
        super.init()
    }

    
    
    func cancel()
    {
        //invalidating Block
        self.callBackBlock = {i in return} // empty block for response in case of cancel
        
        //removing from system
        JSONDownloader.sharedJSONDownloader().removeRequestFromHashMaps(fetchRequest: self)
    }
    
    func callCompletionHandler(jsonString:String)
    {
        self.callBackBlock(jsonString)
    }
}
