//
//  RecommendGameView.swift
//  DouYuDemo
//
//  Created by TS on 2020/7/10.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

private let kgameCellID = "kgameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView{
    
    
    var groups : [AnchorGroup]?{
        didSet{
            //1.移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            
            //2.添加"更多"组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            
            //2.刷新数据
            CollectionView.reloadData()
        }
    }
    
    
@IBOutlet var CollectionView: UICollectionView!
    
    
 //@IBOutlet var contentView: UIView!

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        //加载xib
//        contentView = (Bundle.main.loadNibNamed("RecommendGameView", owner: self, options: nil)?.last as! UIView)
//        // 设置frame
//        contentView.frame = frame
//        //添加上去
//        addSubview(contentView)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    /*** 下面的几个方法都是为了让这个自定义类能将xib里的view加载进来。这个是通用的，我们不需修改。 ****/
    var contentView:UIView!

    //初始化属性配置
    func initial(){
         
        CollectionView.register(UINib(nibName: "GameCell", bundle: nil), forCellWithReuseIdentifier: "GameCell")
        CollectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
     
     
    }

     //初始化时将xib中的view添加进来
     override init(frame: CGRect) {
         super.init(frame: frame)

         

         contentView = loadViewFromNib()
         addSubview(contentView)
         addConstraints()
         //初始化属性配置
         initial()
     }



     //初始化时将xib中的view添加进来
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)

         contentView = loadViewFromNib()
         addSubview(contentView)
         //设置collectionView的layout
         
         addConstraints()
         //初始化属性配置
         initial()

     }

     //加载xib
     func loadViewFromNib() -> UIView {
         let className = type(of: self)
         let bundle = Bundle(for: className)
         let name = NSStringFromClass(className).components(separatedBy: ".").last
         let nib = UINib(nibName: name!, bundle: bundle)
         let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
         return view
     }

     //设置好xib视图约束
     func addConstraints() {
         contentView.translatesAutoresizingMaskIntoConstraints = false
         var constraint = NSLayoutConstraint(item: contentView!, attribute: .leading,
                                             relatedBy: .equal, toItem: self, attribute: .leading,
                                             multiplier: 1, constant: 0)
         addConstraint(constraint)
         constraint = NSLayoutConstraint(item: contentView!, attribute: .trailing,
                                         relatedBy: .equal, toItem: self, attribute: .trailing,
                                         multiplier: 1, constant: 0)
         addConstraint(constraint)
         constraint = NSLayoutConstraint(item: contentView!, attribute: .top, relatedBy: .equal,
                                         toItem: self, attribute: .top, multiplier: 1, constant: 0)
         addConstraint(constraint)
         constraint = NSLayoutConstraint(item: contentView!, attribute: .bottom,
                                         relatedBy: .equal, toItem: self, attribute: .bottom,
                                         multiplier: 1, constant: 0)
         addConstraint(constraint)
     }

}

// mark: --提供快速创建的类方法
//extension RecommendGameView{
//    class func recommendGameView() -> RecommendGameView{
//        return Bundle.main.loadNibNamed("RecommendGameView", owner: self, options: nil)?.last as! UIView as! RecommendGameView
//    }
//}

extension RecommendGameView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath)as! GameCell
        cell.group = groups![indexPath.item]
        return cell
    }
    
    
}
