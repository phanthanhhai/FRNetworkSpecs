//
//  FRNetwork.swift
//  FRNetwork
//
//  Created by haipt on 4/27/16.
//  Copyright © 2016 Framgia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class FRNetwork: NSObject {
    let StatusCodeSuccess = 200
    typealias FailureHandle = (NSError?) -> Void
    
    private var requestManager : Alamofire.Manager!
    private var method : Alamofire.Method!
    private var parameter : [String : AnyObject]?
    private var url : String
    private var failureHandle: FailureHandle!
    
    public init(url : String, httpMethod : Alamofire.Method, parameter : [String : AnyObject]?) {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForResource = 30
        self.requestManager = Alamofire.Manager(configuration: configuration)
        self.url = url
        self.method = httpMethod
        self.parameter = parameter
    }

    public func startService(
        success: (AnyObject?) -> Void,
        failure: (NSError?) -> Void) -> Void
    {
        if failureHandle == nil {
            failureHandle = failure
        }
        switch self.method.rawValue {
        case "POST":
            self.requestManager.request(.POST, url, parameters: self.parameter, headers: nil
                ).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
                    switch response.result {
                    case .Success(let json):
                        let statusCode = response.response?.statusCode
                        if statusCode == self.StatusCodeSuccess {
                            print("Response String: \(json)")
                            success(json)
                        } else {
                            self.processingError(statusCode, data: json)
                        }
                    case .Failure(let error):
                        if let statusCode = response.result.error?.code {
                            self.processingError(statusCode, data: error)
                        }
                    }
            }
            break
            
        case "GET":
            self.requestManager.request(.GET, url, parameters: self.parameter, headers: nil
                ).responseJSON { (response : Response<AnyObject, NSError>) -> Void in
                    switch response.result {
                    case .Success(let json):
                        let statusCode = response.response?.statusCode
                        if statusCode == self.StatusCodeSuccess {
                            print("Response String: \(json)")
                            success(json)
                        } else {
                            self.processingError(statusCode, data: json)
                        }
                    case .Failure(let error):
                        
                        if let statusCode = response.result.error?.code {
                            self.processingError(statusCode, data: error)
                        }
                    }
            }
            break
        default:
            failure(nil)
            break
        }
    }
    
    
    func processingError(statusCode: Int?, data: AnyObject?) {
        print("------------Xu ly loi hoac Maintain-------------")
        let errorInfor = NSError(domain: "Co loi", code: statusCode!, userInfo: nil)
        self.failureHandle(errorInfor)
    }
}