//
//  AppDelegate.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/9.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 2.0)
        //全局修改底部tabbar颜色
        UITabBar.appearance().tintColor = UIColor.orange
        
        return true
    }

    

}

