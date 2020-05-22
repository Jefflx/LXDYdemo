//
//  PageContentView.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/21.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func contentViews(progress : CGFloat, sourceIndex : Int, targetIndex: Int)
}


private let ContentCellId = "ContentCellId"

class PageContentView: UIView {
    //定义属性
    private var childs: [UIViewController]
    private weak var parent: UIViewController?
    private var startOffsetX : CGFloat = 0
    private var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    //懒加载属性
    private lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // heng===
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        return collectionView
        
    }()

    //自定义构造函数
    init(frame: CGRect,childVcs: [UIViewController],parentViewController: UIViewController?) {
        self.childs = childVcs
        self.parent = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//设置UI界面
extension PageContentView{
    private func setupUI(){
        //1.将所有的子控制器添加到父控制器中
        for childvc in childs{
            parent?.addChild(childvc)
        }
        
        //2.添加uicollectionv可我用于在cell中存放控制器view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
}

extension PageContentView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath)
        
        //2.给Cell设置内容
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVc = childs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
}

extension PageContentView: UICollectionViewDelegate{
    //开始偏移
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //0.判断是否是点击事件
        if isForbidScrollDelegate {return}
        
        
        //1. 定义获取需要的数据
        var progress : CGFloat = 0 //滑动进度
        var sourceIndex : Int = 0 //当前页
        var targetIndex : Int = 0 //目标页
        
        //2.判断是左划还是右划
        let currentOffsetX = scrollView.contentOffset.x
        let scrollW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX{//左划
            // 1.计算progress
            progress = currentOffsetX / scrollW - floor(currentOffsetX / scrollW)
            //2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollW)
            //3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childs.count {
                targetIndex = childs.count - 1
            }
            //4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollW{
                progress = 1
                targetIndex = sourceIndex
            }
        } else{//右划
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollW - floor(currentOffsetX / scrollW))
            //2.计算sourceIndex
            targetIndex = Int(currentOffsetX / scrollW)
            //3.计算targetIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childs.count {
                sourceIndex = childs.count - 1
            }
            
        }
        
        // 3.将progress/sourceIndex/targetIndex传递给titleView
        //print("progress:\(progress) sourceIndex:\(sourceIndex) targetIndex:\(targetIndex)")
        delegate?.contentViews(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

//对外开放的方法
extension PageContentView{
    
    func setCurrentIndex(currentIndex : Int){
        //1.记录需要禁止的执行代理方法
        isForbidScrollDelegate = true
        //2.滚动换页面
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
