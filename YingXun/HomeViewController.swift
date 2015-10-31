//
//  HomeViewController.swift
//  YingXun
//
//  Created by wjl on 15/10/26.
//  Copyright © 2015年 麦扣. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var tableView: UITableView!
    private var homeData = [HomeData]()
    private var page: Int = 1
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "每日推荐"
        //设置tableView
        setTableView()
        //集成刷新控件
        self.setupRefresh()
    }
    
    // 集成刷新控件
    func setupRefresh(){
        
        //下拉刷新
        self.tableView.header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "headRefresh")
        //上拉刷新
        self.tableView.footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
        
    }
    
    //执行下拉刷新，进行数据的替换
    func headRefresh(){
        //数据再次加载存在问题
        self.tableView.header.endRefreshing()
    }
    //执行上拉刷新，进行数据的加载
    func footerRefresh(){
        //这里写的很乱，需要修改。。。
        let lastItem = homeData.count
        let query = AVQuery(className: "moviesData")
        query.skip = 4 * page
        query.limit = 4
        query.addDescendingOrder("updatedAt")
        query.findObjectsInBackgroundWithBlock { ( result, error) -> Void in
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                let count = result.count
                guard count != 0 else{
                    //数据加载完全
                    self.tableView.footer.endRefreshingWithNoMoreData()
                    return
                }
                //进行数据加载
                for var i=0 ; i < count ; i++ {
                    let temp = result.first
                    let value = temp?.valueForKey("localData")!
                    let title:String = value!.valueForKey("title")as! String
                    let nowTime: String = value!.valueForKey("date")as! String
                    let videoName:String = value!.valueForKey("videoName")as! String
                    let file = value!.valueForKey("videoImage")as! AVFile
                    let fileUrl = NSURL(string: file.url)
                    let videoImage = NSData(contentsOfURL: fileUrl!)
                    let obj:HomeData = HomeData(time: nowTime, title: title, image: videoImage!,videoName:videoName)
                    self.homeData.append(obj)
                    
                }
                let indexpaths = (lastItem..<self.homeData.count).map{
                    NSIndexPath(forRow: $0, inSection: 0)
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.insertRowsAtIndexPaths(indexpaths, withRowAnimation: UITableViewRowAnimation.None)
                })
            })
        }
        
        page++
        self.tableView.footer.endRefreshing()
        
    }
    func setTableView(){
        
        //加载数据
        self.homeData = HomeData.loadHomeData()as! [HomeData]
       // self.automaticallyAdjustsScrollViewInsets = false
        self.tableView = UITableView(frame: CGRectMake(0, 0, Width, Height), style: UITableViewStyle.Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.view.addSubview(tableView)
    }
    //下面是DataSource的一些方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "homeCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? HomeTableViewCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("HomeTableViewCell", owner: nil, options: nil).last as? HomeTableViewCell
        }
        let cellData:HomeData = self.homeData[indexPath.row]
        cell?.showHomeValue(cellData)
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 252
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    //下面是DeleGate的一些方法
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let vc = DetailViewController()
        vc.key = "北京遇上西雅图"
        self.navigationController?.pushViewController(vc, animated: true)
        //调转完毕之后显示BottomBar
        
    }
    
}
