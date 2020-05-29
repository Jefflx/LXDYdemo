//
//  NSDate-Extension.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/25.
//  Copyright © 2020 TS. All rights reserved.
//

import Foundation

extension NSDate{
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
