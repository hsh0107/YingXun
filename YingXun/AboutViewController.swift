//
//  AboutViewController.swift
//  YingXun
//
//  Created by wjl on 15/10/27.
//  Copyright © 2015年 麦扣. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    init() {
        super.init(nibName: "AboutView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: "AboutWeViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "关于我们"
    }

}
