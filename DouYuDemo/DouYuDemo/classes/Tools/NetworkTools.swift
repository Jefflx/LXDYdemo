//
//  NetworkTools.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/22.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools{
    class func requestData(type : MethodType, url: String, parameters: [String : NSString]? = nil, finishedCallback : (_ result : AnyObject) -> ()) {
        //1.获取类型
        let method = type == .GET ? Method.GET : Method.POST
        
        Alamofire.request(method, url, parameters: parameters).responseJSON{(response) in
            guard let result = response.result.value else{
                print(response.result.error)
                return
            }
            finishedCallback(result: result)
        }
    }

}
