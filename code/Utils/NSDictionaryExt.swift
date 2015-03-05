//
//  NSDictionaryExt.swift
//  BeginX
//
//  Created by tolly on 15/3/5.
//  Copyright (c) 2015年 tolly. All rights reserved.
//

import UIKit
import Foundation

extension NSDictionary{

    func stringAttributeForKey(key:String)->String{
    
        var obj:AnyObject! = self[key]
        if obj as NSObject == NSNull() {
            return ""
        }
        if obj.isKindOfClass(NSNumber){
            var num = obj as NSNumber
            return num.stringValue
        }
        
        return obj as String
    }
    
}