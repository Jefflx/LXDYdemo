//
//  CycleCell.swift
//  DouYuDemo
//
//  Created by TS on 2020/7/9.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit
import Kingfisher

class CycleCell: UICollectionViewCell {

    @IBOutlet var ImgV: UIImageView!
    
    @IBOutlet var NameLabel: UILabel!
    
    
    //定义模型属性
    var cycleModel : CycleModel?{
        didSet{
            NameLabel.text = cycleModel?.title
            //4.设置封面图片
            guard let iconURL = URL(string: cycleModel!.pic_url) else {return}
            
            ImgV.kf.setImage(with: iconURL)
        }
    }

}
