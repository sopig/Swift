//
//  MYHttpRequest.swift
//  BeginX
//
//  Created by tolly on 15/3/5.
//  Copyright (c) 2015年 tolly. All rights reserved.
//

import UIKit
import Foundation

class MYHttpRequest: NSObject {
   
    override init() {
        super.init()
    }
    
    
    class func requestWithURL(urlString:String!,completionHandler:(response:NSURLResponse!,data:NSData!,error:NSError!)->Void){
        
        var URL = NSURL(string: urlString)!
        var req = NSMutableURLRequest(URL: URL)
        req.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:29.0) Gecko/20100101 Firefox/29.0 BY TOLLY", forHTTPHeaderField: "User-Agent")
        var queue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(req, queue: queue) { (response, data, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), {
                
            completionHandler(response: response,data: data,error: error)
                
            })
        }
        
    }
    
    
}
