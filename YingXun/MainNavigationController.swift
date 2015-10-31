//
//  MainNavigationController.swift
//  YingXun
//
//  Created by wjl on 15/10/27.
//  Copyright © 2015年 麦扣. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //返回按钮等待定制
    //重写push方法，隐藏tabbar
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count > 0 {

            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }

}
