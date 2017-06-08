//
//  JSONDownloader.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class JSONDownloader: NSObject {
    
    private static var  _JSONDownloader:JSONDownloader? = nil
    static func sharedJSONDownloader() -> JSONDownloader
    {
        if _JSONDownloader == nil
        {
            _JSONDownloader = JSONDownloader()
        }
        return _JSONDownloader!
    }
    
    private override init() {
        super.init()
    }
    
    func getJSON(withAddress AddUrl: URL,callbackBlock:@escaping (String) -> Void ) -> JSONFetchRequest?
    {
        //check in cache
        let json = JSONCache.sharedJSONCache().getJSON(forURL: AddUrl.absoluteString)
        if (json != nil)
        {
            callbackBlock(json!)
            return nil
        }
        let jsonRequest = JSONFetchRequest()
        jsonRequest.completionBlock = callbackBlock
        jsonRequest.urlStr = AddUrl.absoluteString
        
        var reqArray:[JSONFetchRequest]? = hashRequests[AddUrl.absoluteString]
        if reqArray == nil || reqArray?.count == 0
        {
            reqArray = [JSONFetchRequest]()
            //Start Download Call
            downloadJSONFrom(addressURL: AddUrl)
        }
        //here download already happening
        reqArray!.append(jsonRequest)
        hashRequests[AddUrl.absoluteString] = reqArray!
        return jsonRequest
    }
    
    //MARK : Request Logic
    
    var hashRequests = [String:[JSONFetchRequest]]()
    var hashDownloadTasks = [String:AnyObject]()
    
    
    func distributeDownloadedJSONAmongRequests(addrURL: URL,jsonString:String)
    {
        //Adding JSON to cache and sending back JSON to callers
        JSONCache.sharedJSONCache().addJSONStringToCache(jsonStr: jsonString, urlAddrr: addrURL)
        
        //removing task from hashMap
        self.hashDownloadTasks[addrURL.absoluteString] = nil
        
        //calling completion handlers of all requests
        for req in self.hashRequests[addrURL.absoluteString]!
        {
            req.callCompletionHandler(jsonString: jsonString)
        }
        //removing all requests for this JSON
        self.hashRequests[addrURL.absoluteString] = [JSONFetchRequest]()
    }
    
    func removeRequestFromHashMaps(fetchRequest:JSONFetchRequest)
    {
        var reqArray:[JSONFetchRequest]? = hashRequests[fetchRequest.urlStr]
        if reqArray == nil || reqArray?.count == 0
        {
           return //no reason to do anything is requests not exist
        }
        //removing request
        reqArray!.remove(at: reqArray!.index(of: fetchRequest)!)
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
    
    func downloadJSONFrom(addressURL urlAddr:URL)
    {
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: urlAddr) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                }
                else if let response = response,
                let data = data,
                let string = String(data: data, encoding: .utf8)
                {
                    self.distributeDownloadedJSONAmongRequests(addrURL: response.url!, jsonString: string)
                    print("Response: \(response)")
                }
            }
        //Adding task to hasMap
        self.hashDownloadTasks[urlAddr.absoluteString] = task
        task.resume()
    }
}
