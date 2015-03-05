//
//  FileUtility.swift
//  BeginX
//
//  Created by tolly on 15/3/5.
//  Copyright (c) 2015年 tolly. All rights reserved.
//

import UIKit

class FileUtility: NSObject {
   
    
    //存储文件到沙盒 并返回URI地址
    class func cachePath(fileName:String) ->String{
        var arr = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var path = arr[0] as String
        return "\(path)/\(fileName)"
    }
    
    //将文件保存到指定地址
    class func NSDataCacheToPath(path:String,file: NSData)->Bool{
        
        return file.writeToFile(path, atomically: true)
    }
    
    
    //如果是缓存得图片文件
    class func imageDataFromPath(path:String)->AnyObject{
    
        var isExist = NSFileManager.defaultManager().fileExistsAtPath(path)
        
        if isExist {
            return UIImage(contentsOfFile: path)!
        }else{
            return NSNull()
        }
        
    }
}
