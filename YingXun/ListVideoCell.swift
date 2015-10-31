//
//  ListVideoCell.swift
//  VideoTaste
//
//  Created by wjl on 15/10/17.
//  Copyright © 2015年 wjl. All rights reserved.
//

import UIKit

class ListVideoCell: UICollectionViewCell {
    
    let width = UIScreen.mainScreen().bounds.size.width//获取屏幕宽
    
    var imgView : UIImageView?//cell上的图片
    
    override init(frame: CGRect) {
        
        super.init(frame:frame)
        
        imgView = UIImageView(frame: CGRectMake(0, 0, width, UIScreen.mainScreen().bounds.size.height * 0.25))
        self.addSubview(imgView!)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
