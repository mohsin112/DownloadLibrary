//
//  ImageDownloader.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class ImageDownloader: NSObject {
    
    private static var  _imageDownloader:ImageDownloader? = nil
    static func sharedImageDownloader() -> ImageDownloader
    {
        if _imageDownloader == nil
        {
            _imageDownloader = ImageDownloader()
        }
        return _imageDownloader!
    }
    
    private override init() {
        super.init()
    }
    
    func getImage(withAddress AddUrl: URL,callbackBlock:@escaping (UIImage) -> Void ) -> ImageFetchRequest?
    {
        //check in cache
        let image = ImageCache.sharedImageCache().getImage(forURL: AddUrl.absoluteString)
        if (image != nil)
        {
            callbackBlock(image!)
            return nil
        }
        let imageRequest = ImageFetchRequest()
        imageRequest.completionBlock = callbackBlock
        imageRequest.urlStr = AddUrl.absoluteString
        
        var reqArray:[ImageFetchRequest]? = hashRequests[AddUrl.absoluteString]
        if reqArray == nil || reqArray?.count == 0
        {
            reqArray = [ImageFetchRequest]()
            //Start Download Call
            downloadImageFrom(addressURL: AddUrl)
        }
        //here download already happening
        reqArray!.append(imageRequest)
        hashRequests[AddUrl.absoluteString] = reqArray!
        
        
        
        return imageRequest
    }
    
    //MARK : Request Logic
    
    var hashRequests = [String:[ImageFetchRequest]]()
    var hashDownloadTasks = [String:AnyObject]()
    
    
    func distributeDownloadedImageAmongRequests(addrURL: URL,image:UIImage)
    {
        //Adding image to cache and sending back image to callers
        ImageCache.sharedImageCache().addimageToCache(img: image, urlAddrr: addrURL)
        
        //removing task from hashMap
        self.hashDownloadTasks[addrURL.absoluteString] = nil
        
        //calling completion handlers of all requests
        for req in self.hashRequests[addrURL.absoluteString]!
        {
            req.callCompletionHandler(image: image)
        }
        //removing all requests for this image
        self.hashRequests[addrURL.absoluteString] = [ImageFetchRequest]()
    }
    
    func removeRequestFromHashMaps(fetchRequest:ImageFetchRequest)
    {
        var reqArray:[ImageFetchRequest]? = hashRequests[fetchRequest.urlStr]
        if reqArray == nil || reqArray?.count == 0
        {
           return //no reason to do anything is requests not exist
        }
        //removing request
        let index = reqArray!.index(of: fetchRequest)!
        if(index == -1)
        {
            return
        }
        
        reqArray!.remove(at: index)
        hashRequests[fetchRequest.urlStr] = reqArray!
        
        //cheking is size goes to zero . here we need to remove task as well
        if reqArray!.count == 0
        {
            //canceling the task
            let task = self.hashDownloadTasks[fetchRequest.urlStr] as? URLSessionDataTask
            task?.cancel()
            
            //Removing task from hashMap
            hashDownloadTasks[fetchRequest.urlStr] = nil
        }
    }
    
    func downloadImageFrom(addressURL urlAddr:URL)
    {
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: urlAddr) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                }
                else
                {
                    self.distributeDownloadedImageAmongRequests(addrURL:response!.url!,image: UIImage(data:data!)!)
                    print("Response: \(response!)")
                }
            }
        //Adding task to hasMap
        self.hashDownloadTasks[urlAddr.absoluteString] = task
        task.resume()
    }
}
