//
//  RecommentViewModel.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/25.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

class RecommentViewModel{
    //懒加载属性
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
    private lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    private lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

//发送网络请求
extension RecommentViewModel{
    func requestData(finishCallBack:@escaping()->()){
        //0.定义参数
        let parameters = ["limit" : "4","offset" : "0","time" : NSDate.getCurrentTime()]
        
        //2.创建Group
        let dGroup = DispatchGroup()
        dGroup.enter()//进入组
        //3.请求第一部分推荐数据
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": NSDate.getCurrentTime()]) { (result) in
            
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else{return}
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            //3.遍历字典,并且转成模型对象
            
            //3.1设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //3.2 获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //3.2 离开组
            dGroup.leave()
            
        }
        
        //4.请求第二部分推荐数据
        dGroup.enter()//进入组
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            print("颜值得到的是",result)
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else{return}
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //3.遍历字典,并且转成模型对象
            
            //3.1 设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //3.2 获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            //3.3 离开组
            dGroup.leave()
        }
        
        //5.请求2-12部分游戏数据
        dGroup.enter()//进入组
        NetworkTools.requestData(type: .GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit" : "4","offset" : "0","time": NSDate.getCurrentTime()]) { (result) in
           //print(result)
            //1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else{return}
            //2.根据data该key，获取数组
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {return}
            
            //3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dataArray{
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            //3.4 离开组
            dGroup.leave()
        }
        
        //6.所有的数据都请求到，之后进行排序
        dGroup.notify(queue: .main) {
            print("所有数据都请求到")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
    }
}
