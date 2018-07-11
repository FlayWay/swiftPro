//
//  LJNetworkManager.swift
//  testPro
//
//  Created by ljkj on 2018/7/4.
//  Copyright © 2018年 ljkj. All rights reserved.
//

import UIKit
import AFNetworking

// 导入第三方库的名字

// swift 枚举支持任意数据类型
// switch enum 在oc中只支持整数
enum LJHttpMethod {
    case GET
    case POST
}

// 网络管理工具
class LJNetworkManager: AFHTTPSessionManager {

    // 静态区、常量、闭包
    // 在第一次访问的时候，执行闭包，并且将结果保存在 shared 常量中
    static let shared:LJNetworkManager = {
       
        let instance = LJNetworkManager()
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return instance
    }()
    
    // 用户账户
    lazy var userAccount = LJUserAccount()
    
    // 访问令牌，所有访问都需要令牌
//    var accessToken:String? = "2.00hUXEeCBYYq7D0251603489wetAeC"
//    var accessToken:String?
//    // 微博id
//    var uid:String? = "2424401171"
    var userLogin:Bool {
        return  userAccount.access_token != nil
    }
    
    
    /// 使用一个函数 封装 AFN 的 get 和 post 方法
    ///
    /// - Parameters:
    ///   - method: get post
    ///   - URLString:
    ///   - parameters: URLString 参数字典
    ///   - completion: 完成回调  字典、数组  是否成功
    func request(method:LJHttpMethod = .GET,URLString:String,parameters:[String:Any]?,completion:@escaping (_ json:Any?,_ isSuccess:Bool)->()) {
        
        let success = { (task:URLSessionDataTask,json:Any?)->() in
            
            completion(json,true)
        }
        let failure = { (task:URLSessionDataTask?,error:Error)->() in
            
            print("网络请求失败\(error)")
            // 针对403 处理用户过期 可选 不能参与计算 但是可以进行比较
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token过期了")
            }
            completion(nil,false)
        }
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else {
            post(URLString, parameters: parameters, progress:nil, success: success, failure: failure)
        }
    }
    
    ///  专门负责获取token的网络请求方法
    func tokenRequest(method:LJHttpMethod = .GET,urlString:String,parameters:[String:Any]?,completaion:@escaping (_ json:Any?,_ isSuccess:Bool)->()) {
        
        // 处理token字典
        // 判断token是否为nil 为nil直接返回
        guard let token = userAccount.access_token else {
            
            print("没有token，需要登录")
            completaion(nil,false)
            return
        }
        // 判断 参数字典是否存在 如果为nil 应该新建一个字典
        var parameters = parameters
        if parameters == nil {
            parameters = [String:Any]()
        }
        // 设置参数
        parameters!["access_token"] = token
        request(URLString: urlString, parameters: parameters, completion: completaion)
    }
    
}
