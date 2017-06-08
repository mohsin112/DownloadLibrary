//
//  JSONCache.swift
//  Downloader
//
//  Created by Mohsin Mahmood on 6/8/17.
//  Copyright © 2017 Mohsin Mahmood. All rights reserved.
//

import UIKit

class JSONCache: NSObject {

    private static var  _jsonCache:JSONCache? = nil
    static func sharedJSONCache() -> JSONCache
    {
        if _jsonCache == nil
        {
            _jsonCache = JSONCache()
        }
        return _jsonCache!
    }
    
    var cachedJSON = [JSONObject]()
    
    
    private override init() {
        super.init()
    }
    
    
    func getJSON(forURL:String) -> String?
    {
        let name = forURL.replacingOccurrences(of: "/", with: "")
        for jObj in cachedJSON
        {
            if jObj.nameOfJSON == name
            {
                return jObj.jsonString
            }
        }
        return nil
    }
    
    func addJSONStringToCache(jsonStr:String,urlAddrr:URL)
    {
        let jObj = JSONObject(jsonString: jsonStr, name: urlAddrr.absoluteString)
        self.cachedJSON.append(jObj)
        checkCacheForMemoryLimitOrRemoveExcessJSONs()
    }
    
    func checkCacheForMemoryLimitOrRemoveExcessJSONs()
    {
        if cachedJSON.count > Constants.maxJsonCashedSize && cachedJSON.count > 0
        {
            //needs to remove excess JSON from cache
            var oldestFetchJSON:JSONObject = cachedJSON[0]
            for jObj in cachedJSON
            {
                if jObj.lastUsedDate < oldestFetchJSON.lastUsedDate
                {
                    oldestFetchJSON = jObj
                }
            }
            cachedJSON.remove(at: cachedJSON.index(of: oldestFetchJSON)!)
        }
    }
}
