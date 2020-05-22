//
//  MainVC.swift
//  DouYuDemo
//
//  Created by TS on 2020/5/9.
//  Copyright © 2020 TS. All rights reserved.
//

import UIKit

class MainVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

//        addChildVc(storyName: "Home")
//        addChildVc(storyName: "Live")
//        addChildVc(storyName: "Follow")
//        addChildVc(storyName: "Profile")
    }
    
    private func addChildVc(storyName: String){
        //1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        
        //2.将childVc作为子控制器
        addChild(childVc)
    }
    

   

}
