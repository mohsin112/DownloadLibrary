//
//  ImageFetchRequest.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class ImageFetchRequest: NSObject {
    
    fileprivate var callBackBlock: (UIImage)->Void
    var urlStr:String = ""
    var completionBlock: (UIImage)->Void
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
        ImageDownloader.sharedImageDownloader().removeRequestFromHashMaps(fetchRequest: self)
    }
    
    func callCompletionHandler(image:UIImage)
    {
        self.callBackBlock(image)
    }
}
