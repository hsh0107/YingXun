//
//  MeViewController.swift
//  YingXun
//
//  Created by wjl on 15/10/26.
//  Copyright © 2015年 麦扣. All rights reserved.
//

import UIKit

class MeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private var tableView: UITableView!
    private var meIcons_01 = ["usercenter", "orders", "setting_like"]
    private var meTitles_01 = ["个人中心", "我的动态", "我的收藏"]
    private var meIcons_02 = ["feedback", "recomment"]
    private var meTitles_02 = ["您的建议","关于我们"]
    private var meDetailText = ["become better","影迅"]
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        
        setNavItem()
    }

    private func setNavItem(){
        
        navigationItem.title = "我的"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settinghhhh"), style: UIBarButtonItemStyle.Plain, target: self, action: "setting")
        
    }
    
    private func setTableView(){
        
        self.tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.view.addSubview(tableView)
        
        //设置headView
        let headImageViewHight: CGFloat = 100
        let headImageView = UIImageView(frame: CGRectMake(0, 0, Width, headImageViewHight))
        headImageView.image = UIImage(named: "quesheng")

        //设置头像
        let iconView = UIButton(frame: CGRectMake(10, 10, 80, 80))
        iconView.setImage(UIImage(named: "my"), forState: UIControlState.Normal)
        iconView.addTarget(self, action: "iconButtonClick", forControlEvents: .TouchUpInside)
        iconView.enabled = true
        headImageView.addSubview(iconView)
        
        //设置名字
        let nameLabelHeight:CGFloat = 40
        let nameLabel = UILabel(frame: CGRectMake(CGRectGetMaxX(iconView.frame) + 10, 30, Width, nameLabelHeight))
        nameLabel.text = "个人中心进行登录"
        nameLabel.font = UIFont.systemFontOfSize(20)
        headImageView.addSubview(nameLabel)
        
        tableView.tableHeaderView = headImageView
    }
    
//下面是DataSource的一些方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let identifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell=UITableViewCell(style: .Value1, reuseIdentifier: identifier)
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell!.selectionStyle = .None
        }
        if indexPath.section == 0 {
            cell!.imageView!.image = UIImage(named: meIcons_01[indexPath.row])
            cell!.textLabel?.text = meTitles_01[indexPath.row]
        } else {
            cell!.imageView!.image = UIImage(named: meIcons_02[indexPath.row])
            cell!.textLabel?.text = meTitles_02[indexPath.row]
            cell?.detailTextLabel?.text = meDetailText[indexPath.row]
        }
    
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            if indexPath.row == 0{
                let login = LoginInController()
                navigationController?.pushViewController(login, animated: true)
//                let center = MyCenterViewController()
//                navigationController?.pushViewController(center, animated: true)
            }
            else if indexPath.row == 2{
                let collection = CollectionViewController()
                navigationController?.pushViewController(collection, animated: true)
            }
            
        }
        else{
            if indexPath.row == 0{
                let feedback = FeedbackViewController()
                navigationController?.pushViewController(feedback, animated: true)
            }
            else{
                let about = AboutViewController()
                navigationController?.pushViewController(about, animated: true)
            }
        }
    }
    
//设置头像点击事件
    func iconButtonClick(){
        print("das")
        let login = LoginInController()
        self.navigationController?.pushViewController(login, animated: true)
    }

    func setting(){
        
    }
}
