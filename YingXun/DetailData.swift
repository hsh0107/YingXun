//
//  DetailData.swift
//  VideoTaste
//
//  Created by wjl on 15/10/5.
//  Copyright © 2015年 wjl. All rights reserved.
//

import UIKit
//得到详细的推荐理由
func refreshDetailData(videoName:String)->NSURLRequest{
    
    let query = AVQuery(className: "moviesData")
    
    query.whereKey("videoName", containsString: videoName)
    let result = query.findObjects()
    let firstObj = result.first
    let localData = firstObj!.valueForKey("localData")
    //拿到请求网站的URL
    let stringURL = localData?.valueForKey("detailData") as! String
    
    let url = NSURL(string: stringURL)
    
    let urlRequest = NSURLRequest(URL: url!)
    
    return urlRequest
    
    
}   
