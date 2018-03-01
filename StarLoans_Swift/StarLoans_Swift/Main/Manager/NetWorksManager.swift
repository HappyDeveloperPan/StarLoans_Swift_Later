//
//  NetWorksManager.swift
//  StarLoans_Swift
//
//  Created by iOS Pan on 2017/11/27.
//  Copyright © 2017年 iOS Pan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetWorksManager: NSObject {
    
    /// 数据请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - type: 请求类型
    ///   - parameters: 请求参数
    ///   - success: 成功回调
    ///   - failture: 失败回调
    class func requst(with url: String, type: HTTPMethod, parameters: Dictionary<String , Any>, success: @escaping (_ response : Any) -> (), failture: @escaping (_ error: Error)->()) {
        
        let headers: HTTPHeaders = ["Accept": "application/json"]
//                                    "Accept": "text/javascript",
//                                    "Accept": "text/html",
//                                    "Accept": "text/plain"]

        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 15
        
        print("url:\n\(url)\n")
        print("parameters:\n\(parameters)\n")

        manager.request(url, method: type, parameters: parameters, headers: headers).responseJSON { (response) in
            
            print("response: \n\(String(describing: response.result.value as? [String: AnyObject]))")
            
            switch response.result {
            case .success(let value):
                //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
//                if let value = response.result.value as? [String: AnyObject] {
                success(value)
//                }
            case .failure(let error):
                print("error:\(error)")
                failture(error)
            }
        }
        
    }
    
    
    /// 接口请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - type: 请求类型
    ///   - parameters: 请求参数
    ///   - completionHandler: 数据回调
    class func requst(with url: String, type: HTTPMethod, parameters: Dictionary<String , Any>?, completionHandler: @escaping (_ response : JSON?, _ error: Error?) -> ()) {
        
        let headers: HTTPHeaders = ["Accept": "application/json"]
        //                                    "Accept": "text/javascript",
        //                                    "Accept": "text/html",
        //                                    "Accept": "text/plain"]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 15
        
        print("url:\n\(url)\n")
        print("parameters:\n\(String(describing: parameters))\n")
        
        manager.request(url, method: type, parameters: parameters, headers: headers).responseJSON { (response) in
            
            print("response: \n\(String(describing: response.result.value as? [String: AnyObject]))")
            
            switch response.result {
            case .success(let value):
                if let responseObject = value as? [String: Any] {
                    completionHandler(JSON(responseObject), nil)
                }else {
                    completionHandler(nil,nil)
                }
            case .failure(let error):
                completionHandler(nil, error)
                print("error:\(error)")
            }
        }
        
    }
    
    /// 上传图片(注意: 图片必须为Data||NSData类型, 其他参数尽量传String||NSString)
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - parameters: 传送参数
    ///   - success: 成功回调
    ///   - failture: 失败回调
    class func uploadImages(with url: String, parameters: Dictionary<String , Any>, success: @escaping (_ response : JSON?) -> (), failture: @escaping (_ error: Error)->()) {
        
        let headers: HTTPHeaders = ["Accept": "application/json"]
//                                    "Accept": "text/javascript",
//                                    "Accept": "text/html",
//                                    "Accept": "text/plain"]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 15
        
        print("url:\n\(url)")
        print("parameters:\n\(String(describing: parameters))\n")
        
        manager.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                if value is Data || value is NSData {
                    let imageName = String(describing: NSData()).appending(".png")
                    multipartFormData.append(value as! Data, withName: key , fileName: imageName, mimeType: "image/png")
                }else {
//                    print("parameters:\n\(key, value)")
//                    let str = (value as AnyObject).data(String.Encoding.utf8.rawValue)!
//                    let str: String = value as! String
                    let str = String(stringInterpolationSegment: value)
                    multipartFormData.append(str.data(using: .utf8)!, withName: key)
                }
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: .post, headers: headers) { (encodingResult) in
            switch encodingResult {
            case .success(request: let request, streamingFromDisk: _, streamFileURL: _):
                request.responseJSON(completionHandler: { (response) in
                    
                    print("response: \n\(String(describing: response.result.value as? [String: Any]))")
                    
                    if let myJson = response.result.value as? [String : Any]{
                        success(JSON(myJson))
                    }else {
                        success(nil)
                    }
                })
            case .failure(let error):
                print("error:\(error)")
                failture(error)
            }
        }
    }
}


















