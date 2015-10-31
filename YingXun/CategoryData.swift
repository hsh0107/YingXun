//
//  CategoryData.swift
//  YingXun
//
//  Created by wjl on 15/10/30.
//  Copyright © 2015年 麦扣. All rights reserved.
//

import UIKit

class CategoryData: NSObject {

    var imageView: String!
    var categoryName:String!
    init(imageView:String,categoryName:String) {
        
        self.imageView = imageView
        self.categoryName = categoryName
    }
    
    
}
