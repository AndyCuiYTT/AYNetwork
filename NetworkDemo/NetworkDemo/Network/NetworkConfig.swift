//
//  NetworkConfig.swift
//  NetworkDemo
//
//  Created by Andy on 2017/7/17.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//

import UIKit

class NetworkConfig: NSObject {

    class var timeoutInterval: TimeInterval {
        return 30
    }
    
    class var configuration: URLSessionConfiguration {
        return URLSessionConfiguration.default
    }
    
    class var downloadPath: String {
        
        let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first?.appending("/download/")
        let fileManager = FileManager()
        if !fileManager.fileExists(atPath: path!) {
            try! fileManager.createDirectory(atPath: path!, withIntermediateDirectories: true, attributes: nil)
        }
        return path!
    }
    
    
    
}
