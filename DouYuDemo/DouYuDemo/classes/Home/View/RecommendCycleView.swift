//
//  RecommendCycleView.swift
//  DouYuDemo
//
//  Created by TS on 2020/6/2.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

//无限循环
class RecommendCycleView: UIView{
    var cycleTimer : Timer?
    
    var cycleModels : [CycleModel]?{
        didSet {
            //刷新collectionview
            CollectionView.reloadData()
            //2.设置pagecontroller
            PageController.numberOfPages = cycleModels?.count ?? 0
            //3.默认滚动到中间某一个位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 100, section: 0)
            CollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            //4.添加定时器
            removeCycleTimer()
            addCycleTimer()
            
        }
    }
    
    @IBOutlet var PageController: UIPageControl!
    @IBOutlet var CollectionView: UICollectionView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = CollectionView.bounds.size
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.scrollDirection = .horizontal
            CollectionView.isPagingEnabled = true
        
        
    }
    
   
    
   /*** 下面的几个方法都是为了让这个自定义类能将xib里的view加载进来。这个是通用的，我们不需修改。 ****/
   var contentView:UIView!

   //初始化属性配置
   func initial(){
        //注册Cell
        let nib = UINib(nibName: "CycleCell", bundle: nil)
        CollectionView.register(nib, forCellWithReuseIdentifier: "CycleCell")
        CollectionView.isPagingEnabled = true
        
        
    
    
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



extension RecommendCycleView:UICollectionViewDataSource{
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CycleCell", for: indexPath)as! CycleCell
       
        let models = cycleModels![indexPath.item % cycleModels!.count]
        cell.cycleModel = models
        return cell
    }
    
    
}

extension RecommendCycleView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2.计算pageController的currentIndex
        PageController.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
        
    }
    
}

//对定时器的操作方法
extension RecommendCycleView {
    //添加定时器
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    //移除定时器
    private func removeCycleTimer(){
        cycleTimer?.invalidate() //从运行循环中移除
        cycleTimer = nil
    }
    
    @objc private func scrollToNext(){
        //1.获取滚动的偏移量
        let currentOffsetX = CollectionView.contentOffset.x
        let offsetX = currentOffsetX + contentView.bounds.width
        
        //2.滚动该位置
        CollectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //用户手动拖拽移除定时器
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //用户听着拖拽
        addCycleTimer()
    }
    
}
