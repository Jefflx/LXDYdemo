//
//  CollectionNomalCell.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/22.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

class CollectionNomalCell: UICollectionViewCell {
    
@IBOutlet weak var ImgView: UIImageView!

@IBOutlet weak var nickNameLabel: UILabel!
    
@IBOutlet weak var onlineBtn: UIButton!


@IBOutlet weak var roomNameLabel: UILabel!
    
    
    // 定义模型属性
    var anchor : AnchorModel?{
        didSet{
           //0.校验模型是否有值
            guard let anchor = anchor else{return}
            //1.取出在线人数的显示文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            //2.昵称显示
            nickNameLabel.text = anchor.nickname
           
        }
    }

}
