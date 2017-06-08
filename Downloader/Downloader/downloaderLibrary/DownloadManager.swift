//
//  DownloadManager.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class DownloadManager: NSObject
{
    private static var  _downloadManager:DownloadManager? = nil
    static func sharedDownloadManager() -> DownloadManager
    {
        if _downloadManager == nil
        {
            _downloadManager = DownloadManager()
        }
        return _downloadManager!
    }
    
    private override init() {
        super.init()
    }
    
    
    //get Image From Server
    
    func getImage(withAddressURL AddUrl: URL,callbackBlock:@escaping (UIImage) -> Void ) -> ImageFetchRequest?
    {
        return ImageDownloader.sharedImageDownloader().getImage(withAddress:AddUrl, callbackBlock: callbackBlock)
    }
    
    //get JSON From Server
    func getJSON(withAddress AddUrl: URL,callbackBlock:@escaping (String) -> Void ) -> JSONFetchRequest?
    {
        return JSONDownloader.sharedJSONDownloader().getJSON(withAddress: AddUrl, callbackBlock:  callbackBlock)
    }
}
