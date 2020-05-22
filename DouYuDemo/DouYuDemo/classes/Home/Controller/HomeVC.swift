//
//  HomeVC.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/11.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class HomeVC: UIViewController {
    
    //懒加载属性
    private lazy var pageTitleView: PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        //let titleView = PageTitleView(frame:titleFrame, titles: titles)
        let titleView = PageTitleView(frame:titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView: PageContentView = {[weak self] in
        //1.确定内容的frame
        let contentH = kScreenH - kNavigationBarH - kStatusBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y:kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommentVC())
        for _ in 0..<3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
       
    }
    

   
}

extension HomeVC{
    private func setupUI(){
        //0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setupNavigationBar()
        //2.添加TitleView
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.cyan
    }
    
    private func setupNavigationBar(){
        //1.设置左侧的item

        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2.设置右侧的item
        let size = CGSize(width: 40, height: 40)

        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)
        

        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}

extension HomeVC: PageTitleViewDelegate{
    func Page(selectedIndex: Int) {
        pageContentView.setCurrentIndex(currentIndex: selectedIndex)
    }
    
}

extension HomeVC: PageContentViewDelegate{
    func contentViews(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
