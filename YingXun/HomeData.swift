//
//  HomeData.swift
//  YingXun
//
//  Created by wjl on 15/10/26.
//  Copyright © 2015年 麦扣. All rights reserved.
//

import UIKit

class HomeData: NSObject {

    var timeLabel: String!
    var titleLabel:String!
    var imageView: NSData!
    var nameLabel:String!
    init(time:String,title:String,image:NSData,videoName:String) {
        self.timeLabel = time
        self.titleLabel = title
        self.imageView = image
        self.nameLabel = videoName
    }
    
    class func loadHomeData()->NSArray{

        var homeData:[HomeData] = []
        //这里有一个线程的问题，日后要解决
        let query = AVQuery(className: "moviesData")
        query.whereKey("videoName", notEqualTo: "")
        query.limit = 4
        query.addDescendingOrder("updatedAt")
        let results = query.findObjects() as NSArray
        for value in results{

           // let videoName:String = value.valueForKey("VideoName")as! String
            let title:String = value.valueForKey("title")as! String
            let nowTime: String = value.valueForKey("date")as! String
            let videoName:String = value.valueForKey("videoName")as! String
            let file = value.valueForKey("videoImage")as! AVFile
            let fileUrl = NSURL(string: file.url)
            let videoImage = NSData(contentsOfURL: fileUrl!)
            let obj:HomeData = HomeData(time: nowTime, title: title, image: videoImage!,videoName:videoName)
            homeData += [obj]

        }
        
        return homeData
    }
}
