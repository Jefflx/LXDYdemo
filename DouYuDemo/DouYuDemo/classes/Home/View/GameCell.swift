//
//  GameCell.swift
//  DouYuDemo
//
//  Created by TS on 2020/7/10.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit
import Kingfisher

class GameCell: UICollectionViewCell {
    
    @IBOutlet var iconimage: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            let iconURL = URL(string: group!.icon_url)//home_more_btn
            
            iconimage.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
            iconimage.layer.cornerRadius = iconimage.frame.size.width / 2

            iconimage.layer.masksToBounds = true

            //iconimage.contentMode = iconimage.ContentMode.center
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
