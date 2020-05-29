//
//  CollectionHeaderView.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/22.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
@IBOutlet weak var iconImageView: UIImageView!

@IBOutlet weak var titleLabel: UILabel!
    
    var group : AnchorGroup? {
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named:group?.icon_name ?? "home_header_hot")
        }
    }
    
    
}
