//
//  RecommendCycleView.swift
//  DouYuDemo
//
//  Created by TS on 2020/6/2.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

//无限循环
class RecommendCycleView: UIView{

   

}
//提供一个快速创建view的类方法
extension RecommendCycleView{
    class func recommendCycleView() ->RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
        //return recommendCycleView()
    }
}
