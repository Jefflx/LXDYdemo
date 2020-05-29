//
//  RecommentVC.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/22.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

class RecommentVC: UIViewController {
    

//懒加载属性
    private lazy var recommendVM : RecommentViewModel = RecommentViewModel()
    private lazy var collectionView : UICollectionView = {[weak self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0 //行间距
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //2.创建uicollectionview
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth] //daxiao
        collectionView.register(UINib(nibName: "CollectionNomalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "PrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()

    
//推荐
    override func viewDidLoad() {
        super.viewDidLoad()
       
       //设置ui界面
        setupUI()
        //发送网络请求
        recommendVM.requestData {
            self.collectionView.reloadData()
        }
        
    }
    
}


//设置ui界面
extension RecommentVC{
    private func setupUI(){
        //1.添加collectionview
        view.addSubview(collectionView)
    }
}

//请求数据
extension RecommentVC{
    private func loadData(){
        //NetworkTools.requestData(type: .POST, URLString: <#T##String#>, parameters: <#T##[String : Any]?#>, finishedCallback: <#T##(Any) -> ()#>)
    }
}

//UICollectionViewDataSource的数据源协议
extension RecommentVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出模型对象
      
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        //2.取出cell
        if indexPath.section == 1{
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)as! PrettyCell
            cell.anchor = anchor
          return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)as! CollectionNomalCell
            cell.anchor = anchor
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的headerview
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)as! CollectionHeaderView
        //2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    

    
}
