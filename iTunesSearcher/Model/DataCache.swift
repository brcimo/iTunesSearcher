//
//  DataManagerCache.swift
//  iTunesSearcher
//
//  Created by Bryan Cimo on 12/13/15.
//  Copyright © 2015 Bryan Cimo. All rights reserved.
//

import Foundation
import UIKit

class DataCache: NSObject
{
    // MARK: - Vars
    var searchItemsList = NSArray()
    var session: NSURLSession? = nil
    var dataTask: NSURLSessionDataTask? = nil
    
    static let sharedInstance = DataCache()
    
    // MARK: - Init
    override init()
    {
    }
    
}
