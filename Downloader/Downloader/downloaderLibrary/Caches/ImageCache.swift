//
//  ImageCache.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class ImageCache: NSObject {

    private static var  _imageCache:ImageCache? = nil
    static func sharedImageCache() -> ImageCache
    {
        if _imageCache == nil
        {
            _imageCache = ImageCache()
        }
        return _imageCache!
    }
    
    var cachedImages = [ImageObject]()
    
    
    private override init() {
        super.init()
    }
    
    
    func getImage(forURL:String) -> UIImage?
    {
        let name = forURL.replacingOccurrences(of: "/", with: "")
        for imageObj in cachedImages
        {
            if imageObj.nameOfImage == name
            {
                return imageObj.image
            }
        }
        return nil
    }
    
    func addimageToCache(img:UIImage,urlAddrr:URL)
    {
        let imageObj = ImageObject(image: img, name: urlAddrr.absoluteString)
        self.cachedImages.append(imageObj)
        checkCacheForMemoryLimitOrRemoveExcessImages()
    }
    
    func checkCacheForMemoryLimitOrRemoveExcessImages()
    {
        if cachedImages.count > Constants.maxImagesCachedSize && cachedImages.count > 0
        {
            //needs to remove excess image from cache
            var oldestFetchImage:ImageObject = cachedImages[0]
            for imageObj in cachedImages
            {
                if imageObj.lastUsedDate < oldestFetchImage.lastUsedDate
                {
                    oldestFetchImage = imageObj
                }
            }
            cachedImages.remove(at: cachedImages.index(of: oldestFetchImage)!)
        }
    }
}
