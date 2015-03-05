//
//  MYRequest.swift
//  BeginX
//
//  Created by tolly on 15/3/5.
//  Copyright (c) 2015年 tolly. All rights reserved.
//

import UIKit
import Foundation

var _requestOperationQueue: NSOperationQueue?

class MYRequest: NSObject,NSURLConnectionDataDelegate {
   
    typealias MYRequestCompletionHandler = (NSURLResponse?, NSData?, NSError?) -> Void
    
    var url:NSURL
    var method = "GET"
    var body = NSData()
    var headers: Dictionary<String,String> = Dictionary()
    var parameters: Dictionary<String,String> = Dictionary()
    var connection:NSURLConnection?
    var response:NSURLResponse?
    lazy var responseData = NSMutableData()
    var completionHandler: MYRequestCompletionHandler
    
    
    var contentType:String?{
        set{
            headers["Content-Type"] = newValue
        }
        get{
            return headers["Content-Type"]
        }
    }
    
    var userAgent: String?{
        set{
            headers["User-Agent"] = newValue
        }
        get{
           return headers["User-Agent"]
        }
    }
    
    
    init(url:NSURL) {
        self.url = url
        self.completionHandler = {response,data,err in}
    }
    
    
    //request Loading...
    
    func loadWithCompletion(completionHandler:MYRequestCompletionHandler){
       self.completionHandler = completionHandler
       loadRequest()
    }
    
    func loadRequest(){
        if parameters.count > 0 {
            serializeRequestParameters()
        }
        
        if _requestOperationQueue == nil{
            _requestOperationQueue = NSOperationQueue()
            _requestOperationQueue!.maxConcurrentOperationCount = 4
            _requestOperationQueue!.name = "com.tolly.MYRequest"
        }
        
        if connection == nil {
            connection = NSURLConnection(request:urlRequest() , delegate: self)
            connection!.setDelegateQueue(_requestOperationQueue)
            connection!.start()
        }
    }
    
    func urlRequest()->NSMutableURLRequest{
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = method
        request.HTTPBody = body
        request.setValue("Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:29.0) Gecko/20100101 Firefox/29.0 BY TOLLY",forHTTPHeaderField:"User-Agent")
        
        for (field, value) in headers {
            request.setValue(value, forHTTPHeaderField: field)
        }
        
        if body.length > 0 {
            request.setValue(String(body.length), forHTTPHeaderField: "Content-Length")
        }
        
        return request
    }
    
    //Request Parameters
    
    func serializeRequestParameters(){
        contentType = "application/x-www-form-urlencoded"
        
        if method == "GET"{
            url = queryParametersURL()!
            println(url)
        } else {
            body = serializeRequestBody()
        }
        
    }
    
    func serializeRequestBody() -> NSData {
     return queryString().dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    }
    
    func queryParametersURL() -> NSURL?{
        return NSURL(string: url.absoluteString! + queryString())
    }
    
    func queryString() -> String {
        var result = "?"
        var firstPass = true
        
        for (key,value) in parameters {
            let encodedKey:NSString = key.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            let encodedValue:NSString = value.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            
            result += firstPass ? "\(encodedKey)=\(encodedValue)" : "&\(encodedKey)=\(encodedValue)"
            
            firstPass = false
        }
        
        return result
    }
    
    
    
    // NSURLConnectionDataDelegate
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        completionHandler(nil,nil,error)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.response = response
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        responseData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        completionHandler(response,responseData,nil)
    }
    
}
