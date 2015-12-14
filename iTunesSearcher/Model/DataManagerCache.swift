//
//  DataManagerCache.swift
//  iTunesSearcher
//
//  Created by Bryan Cimo on 12/13/15.
//  Copyright © 2015 Bryan Cimo. All rights reserved.
//

import Foundation
import UIKit

class DataManagerCache: NSObject
{
    // MARK: - Vars
    var searchItemsList = NSArray()
    
    static let sharedInstance = DataManagerCache()
    
    // MARK: - Init
    override init()
    {
    }
    
    //  MARK: - Func
    func searchForItems(itemType: String, mediaType: String = "all")
    {
        dictionaryFromJSON(NSString(string: "https://itunes.apple.com/search?term=\(itemType)&media=\(mediaType)"))
    }
    
    func dictionaryFromJSON(urlString: NSString)
    {
        let linkString = NSString(string: urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        let request = NSURLRequest(URL: NSURL(string: linkString as String)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: 10.0)
        var response: NSURLResponse?
        do
        {
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            if let dictionary = convertJSONDataToDictionary(data)
            {
                searchItemsList = dictionary["results"] as! NSArray
                //print("\(searchItemsList)")
            }
        }
        catch (let error)
        {
            print(error)
        }
    }
    
    func convertJSONDataToDictionary(dataObject: NSData) -> NSDictionary?
    {
        if let jsonResultDictionary = (try? NSJSONSerialization.JSONObjectWithData(dataObject, options: NSJSONReadingOptions.MutableContainers)) as? NSDictionary
        {
            return jsonResultDictionary
        }
        else
        {
            return nil
        }
    }

}
