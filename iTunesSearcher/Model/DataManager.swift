//
//  DataManager.swift
//  iTunesSearcher
//
//  Created by Bryan Cimo on 12/14/15.
//  Copyright © 2015 Bryan Cimo. All rights reserved.
//

import Foundation


protocol APIDelegate
{
    func didFinish()
    func didFinishWithJSONData(responseDictionary: NSDictionary?)
    func didFail()
}

class DataManager: NSObject, NSURLSessionDelegate
{
    var delegate: APIDelegate? = nil
    var session: NSURLSession? = nil
    var dataTask: NSURLSessionDataTask? = nil
    
    override init()
    {
    }
    
    init(delegate: APIDelegate)
    {
        self.delegate = delegate
    }
    
    func getSession() -> NSURLSession
    {
        if (session == nil)
        {
            let configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
            session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        }
        return session!
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
    
    func getJSONFromURLString(myUrl: NSString)
    {
        let linkString = NSString(string: myUrl.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        self.dataTask?.cancel()

        self.dataTask = self.getSession().dataTaskWithURL(NSURL(string: linkString as String)!, completionHandler: { (data: NSData? , response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil)
            {
                print("\(error?.localizedDescription)")
            }
            else
            {
                if (data != nil && data?.length > 0)
                {
                    var returnData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    returnData  = returnData!.stringByReplacingOccurrencesOfString("\\", withString: "")
                    do
                    {
                        if let dictionary = self.convertJSONDataToDictionary(data!)
                        {
                            DataCache.sharedInstance.searchItemsList = dictionary["results"] as! NSArray
                            self.delegate?.didFinishWithJSONData(dictionary)
                        }
                    }
                }
            }
        })
        self.dataTask?.resume()
    }
    
}