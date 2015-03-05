//
//  NSStringExt.swift
//  BeginX
//
//  Created by tolly on 15/3/5.
//  Copyright (c) 2015年 tolly. All rights reserved.
//
import UIKit
import Foundation

extension String{
    
    func stringHeightWith(fontSize:CGFloat,width:CGFloat) ->CGFloat{
        var font = UIFont.systemFontOfSize(fontSize)
        var size = CGSizeMake(CGFloat(width), CGFloat.max)
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
        var attributes = [NSFontAttributeName:font , NSParagraphStyleAttributeName:paragraphStyle.copy()]
        
        var text = self as NSString
        var rect = text.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return CGFloat(rect.size.height)
    }
    
    func dateStringFromTimestamp(timeStamp:NSString) ->String{
        var ts = timeStamp.doubleValue
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:MM:ss"
        var date = NSDate(timeIntervalSince1970: ts)
        
        return formatter.stringFromDate(date)
    }
}