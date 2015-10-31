//
//  MainTabBarController.swift
//  YingXun
//
//  Created by wjl on 15/10/26.
//  Copyright © 2015年 麦扣. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addAllChild()
        
    }

    private func addAllChild(){
        // 主页、每日推荐
        tabBarAddChildView(HomeViewController(), title: "今日推荐", image: "recommendation_1", selected: "recommendation_2")
        //分类推荐
        tabBarAddChildView(CategoryViewController(), title: "分类", image: "classification_1", selected: "classification_2")
        //我的
        tabBarAddChildView(MeViewController(), title: "我的", image: "my_1", selected: "my_2")
    }

    private func tabBarAddChildView(childVC:UIViewController,title:String,image:String,selected:String){
        
        childVC.tabBarItem = UITabBarItem(title: title, image: UIImage(named: image), selectedImage:UIImage(named: selected))
        //设置点击之后的字体颜色
        self.tabBar.tintColor = UIColor.blackColor()
        //设置导航控制器
        let nv = MainNavigationController(rootViewController: childVC)
        addChildViewController(nv)
        
    
    }
    
    
}
