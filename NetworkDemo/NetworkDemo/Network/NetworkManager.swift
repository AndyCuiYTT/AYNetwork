//
//  NetworkManager.swift
//  NetworkDemo
//
//  Created by Andy on 2017/7/17.
//  Copyright © 2017年 AndyCuiYTT. All rights reserved.
//


/**
 *  系统网络请求封装
 */
import UIKit

class NetworkManager: NSObject {
    
    
    class func networkPost(_ urlStr: String, params: [String : String], result: @escaping (Any) -> Void, fail: @escaping (Any) -> Void) {
        var request = URLRequest.init(url: URL(string: urlStr)!)
        request.timeoutInterval = NetworkConfig.timeoutInterval
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch  {
            print(error)
        }
        
        let session = URLSession(configuration: NetworkConfig.configuration)
        let task = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let value = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    result(value)
                }else {
                    result (String.init(data: data!, encoding: .utf8)!)
                }
                
            }else {
                fail(error.debugDescription)
            }
        }
        task.resume()
    }
    
    
    class func networkDownload(_ urlStr: String, fileName: String, result: @escaping (String) -> Void, fail: @escaping (Any) -> Void) {
        
        let request = URLRequest.init(url: URL(string: urlStr)!)
        let session = URLSession(configuration: NetworkConfig.configuration)
        
        let task = session.downloadTask(with: request) { (pathUrl, response, error) in
            if error == nil {
                if let filePath: String = pathUrl?.path {
                    let fileManager = FileManager()
                    try! fileManager.moveItem(atPath: filePath, toPath: NetworkConfig.downloadPath.appending(fileName))
                    try! fileManager.removeItem(atPath: filePath)
                    result(NetworkConfig.downloadPath.appending(fileName))
                }
            }else {
                fail(error.debugDescription)
            }
        }
        
        task.resume()
    }
    
    
    /// 仿 form 表单多文件上传
    ///
    /// - Parameters:
    ///   - urlStr: 上传文件路径
    ///   - params: 请求参数
    ///   - filesData: 文件数据
    ///   - fileName: 文件名
    ///   - fileExtensions: 文件扩展名
    ///   - contentType: 文件类型
    ///   - result: 返回数据
    ///   - fail: 失败
    class func networkUpload(_ urlStr: String, params: [String : String], filesData: [Data], fileName: String, fileExtensions:String, contentType: String,result: @escaping (Any) -> Void, fail: @escaping (Any) -> Void) {
        let boundary = "*****" // 分界标识
        var bodyData = Data()
        
        // 添加普通参数
        for (key , value) in params {
            bodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            bodyData.append("Content-Disposition:form-data;name=\"\(key)\"\r\n".data(using: .utf8)!)
            bodyData.append("Content-Type:text/plain;charset=utf-8\r\n\r\n".data(using: .utf8)!)
            bodyData.append("\(value)".data(using: .utf8)!)
        }
        
        // 添加文件数据
        for i in 0 ..< filesData.count {
            bodyData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            bodyData.append("Content-Disposition:form-data; name=\"file\";filename=\(fileName)-\(i).\(fileExtensions)\r\n".data(using: .utf8)!)
            bodyData.append("Content-Type: \(contentType)\r\n\r\n".data(using: .utf8)!)
            bodyData.append(filesData[i])
        }
        bodyData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        // 设置 request
        var request = URLRequest(url: URL(string: urlStr)!)
        request.addValue("multipart/form-data;boundary=\"\(boundary)\";charset=\"UTF-8\"", forHTTPHeaderField: "Content-Type")
        request.addValue("\(bodyData.count)", forHTTPHeaderField: "Content-Length")
        request.httpMethod = "POST"
        request.httpBody = bodyData
        
        // 发起请求
        let session = URLSession(configuration: NetworkConfig.configuration)
        let task = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let value = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    result(value)
                }else {
                    result (String.init(data: data!, encoding: .utf8)!)
                }
            }else {
                fail(error?.localizedDescription ?? "error")
            }
        }
        task.resume()
    }
}
