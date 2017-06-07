//
//  ViewController.swift
//  AYNetwork_Swift
//
//  Created by Andy on 2017/6/7.
//  Copyright © 2017年 Andy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
    
    }
    @IBAction func loadData(_ sender: UIButton) {
        
//        
//        AYNetworkManager.ay_get("http://localhost:8080/MavenDemo/userApi?method=getAllUsers", result: { (resultData) in
//            print(resultData)
//        }) { (failData) in
//            print(failData)
//        }
//        
        
        AYNetworkManager.ay_download("https://github.com/AndyCuiYTT/AYWebImage/archive/master.zip", fileURL: URL.init(fileURLWithPath: self.ay_getCachePath()), progress: { (progress) in
            
            print(progress);
            
            
        }, result: { (resultData) in
            print(resultData);
        }) { (failData) in
            print(failData)
            
        }
        
        
    }
    
    
    /// 获取图片缓存路径
    ///
    /// - Returns: 图片缓存路径
    private func ay_getCachePath() -> String {
        let fileStr: String = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last?.appending("/imageCache"))!
        let fileManager: FileManager = FileManager.default;
        
        if !fileManager.fileExists(atPath: fileStr) {
            try? fileManager.createDirectory(atPath: fileStr, withIntermediateDirectories: true, attributes: nil);
        }
        return fileStr
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

