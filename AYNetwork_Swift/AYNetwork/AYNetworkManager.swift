//
//  AYNetworkManager.swift
//  AYNetwork_Swift
//
//  Created by Andy on 2017/6/7.
//  Copyright © 2017年 Andy. All rights reserved.
//


/**
 *  github:https://github.com/AndyCuiYTT/AYNetwork_Swift.git
 *
 *  该类基于 Alamofire ,使用时请先导入 Alamofire 库
 *
 *  该类所有方法均为静态方法,使用时不用实例化对象,可直接调用
 */

import UIKit
import Alamofire

class AYNetworkManager: NSObject {
    
    
    
    /// post 请求
    ///
    /// - Parameters:
    ///   - urlStr: 请求网络地址
    ///   - params: 请求参数
    ///   - result: 成功返回数据
    ///   - fail: 失败返回数据
    static func ay_post(_ urlStr: String ,_ params: Dictionary<String, Any> , result: @escaping (Any)->Void , fail: @escaping (Any)->Void){
        Alamofire.request(urlStr, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess{
                result(response.result.value!)
            }else{
                fail(response.error?.localizedDescription ?? "Error");
            }
        }
    }
    
    
    /// get 请求
    ///
    /// - Parameters:
    ///   - urlStr: 请求网络地址
    ///   - params: 请求参数
    ///   - result: 请求成功返回数据
    ///   - fail: 请求失败返回数据
    static func ay_get(_ urlStr: String ,_ params: Dictionary<String, Any> , result: @escaping (Any)->Void , fail: @escaping (Any)->Void){
        Alamofire.request(urlStr, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess{
                result(response.result.value!)
            }else{
                fail(response.error?.localizedDescription ?? "Error");
            }
        }
    }

    
    
    
    
    
    
}
