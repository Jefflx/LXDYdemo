//
//  AnchorModel.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/25.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit
import SwiftyJSON

class AnchorModel: NSObject {
   //房间id
 @objc var room_id : Int = 0
    
    //房间图片对应的url
 @objc var vertical_src : String = ""
    // 判断是手机直播还是电脑直播 0：电脑直播 1: 手机直播
 @objc var isVertical: Int = 0
    // 房间名称
 @objc var room_name: String = ""
    // 主播昵称
 @objc var nickname: String = ""
    // 观看人数
 @objc var online: Int = 0
    // 所在城市
 @objc var anchor_city : String = ""
    
    init(dict : [String :NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
//    init(dict : [String :JSON]) {
//        super.init()
//        setValuesForKeys(dict)
//    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
