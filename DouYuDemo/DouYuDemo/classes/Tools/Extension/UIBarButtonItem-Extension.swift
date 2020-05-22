//
//  UIBarButtonItem-Extension.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/20.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    //1.类方法
//    class func createItem(imageName: String,hightImageName: String,size: CGSize) -> UIBarButtonItem{
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imageName), for: .normal)
//        btn.setImage(UIImage(named: hightImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//
//        return UIBarButtonItem(customView: btn)
//    }
    
    //2.便利构造函数： 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数（self）
    convenience init(imageName: String,hightImageName: String = "",size: CGSize = CGSize.zero) {
        //1.创建一个uibutton
        let btn = UIButton()
        //2.设置btn的图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hightImageName != ""{
            btn.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        //3.设置btn的尺寸
        if size == CGSize.zero{
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        //4.创建uibarbuttonitem
        self.init(customView: btn)
    }
    
}
