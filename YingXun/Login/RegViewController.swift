//
//  RegViewController.swift
//  VideoLogin
//
//  Created by wjl on 15/10/18.
//  Copyright © 2015年 wjl. All rights reserved.
//

import UIKit

class RegViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    private var tableView: UITableView!
    private var mailText:UITextBox!
    private var password:UITextBox!
    private var userName:UITextBox!
    private  var possibleInputs : CheckInputs = []

    private var doneButton : UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        
        setNavItem()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //邮箱验证
        let mailValidator = AJWValidator(type: AJWValidatorType.String)
        mailValidator.addValidationToEnsureValidEmailWithInvalidMessage("邮箱格式不对")
        mailText?.ajw_attachValidator(mailValidator)
        
        mailValidator.validatorStateChangedHandler = {(newState: AJWValidatorState)-> Void in
            switch newState{
            case .ValidationStateValid:
                self.mailText!.highlightState = UITextBoxHighlightState.Default
                self.possibleInputs.unionInPlace(CheckInputs.mail)
            default:
                let errorMsg = mailValidator.errorMessages.first as! String
                self.mailText!.highlightState = UITextBoxHighlightState.Wrong(errorMsg)
                self.possibleInputs.subtractInPlace(CheckInputs.mail)
            }
            self.doneButton?.enabled = self.possibleInputs.isAllOk()
            
        }
        //用户名验证
        let validator = AJWValidator(type: AJWValidatorType.String)
        validator.addValidationToEnsureMinimumLength(3, invalidMessage: "用户名至少三位")
        validator.addValidationToEnsureMaximumLength(16, invalidMessage: "用户名太长")
        userName?.ajw_attachValidator(validator)
        
        validator.validatorStateChangedHandler = {(newState: AJWValidatorState)-> Void in
            switch newState{
            case .ValidationStateValid:
                self.userName!.highlightState = UITextBoxHighlightState.Default
                self.possibleInputs.unionInPlace(CheckInputs.user)
                self.possibleInputs.unionInPlace(CheckInputs.pass)
            default:
                let errorMsg = validator.errorMessages.first as! String
                self.userName!.highlightState = UITextBoxHighlightState.Wrong(errorMsg)
                self.possibleInputs.subtractInPlace(CheckInputs.user)
                self.possibleInputs.subtractInPlace(CheckInputs.pass)
                
            }
            self.doneButton?.enabled = self.possibleInputs.isAllOk()
        }

    }
    

    private func setNavItem(){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "done")
        self.navigationItem.rightBarButtonItem?.enabled = false
        doneButton = self.navigationItem.rightBarButtonItem
    }
    
    private func setTableView(){
        
        self.tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.view.addSubview(tableView)
        
    }
    //下面是DataSource的一些方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 4
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "regViewCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? RegViewCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("RegViewCell", owner: nil, options: nil).last as? RegViewCell
        }
        
        if indexPath.section == 0{
            if indexPath.row == 0{
                cell?.textField.placeholder = "输入邮箱"
                mailText = cell?.textField
            }
            else if indexPath.row == 1{
                cell?.textField.placeholder = "输入用户名"
                userName = cell?.textField
            }
            else{
                cell?.textField.secureTextEntry = true
                cell?.textField.placeholder = "输入密码"
                password = cell?.textField
            }
        }
        else{
            cell?.textField.placeholder = "喜欢的电影分类"
        }
        return cell!
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "必填项"
        }
        else{
            return "选填项"
        }
    }


    
    //注册
    func done(){
        
        //菊花转动，等
        self.pleaseWait()
        
        let user = AVObject(className: "AllUser")
        user["mail"] = self.mailText!.text
        user["password"] = self.password!.text
        user["userName"] = self.userName!.text
        //查询用户是否已经注册
        let queryUser = AVQuery(className: "AllUser")
        
        queryUser.whereKey("mail", equalTo: self.mailText!.text)
        
        queryUser.getFirstObjectInBackgroundWithBlock { (existUser, e) -> Void in
            
            self.clearAllNotice()
            
            if(existUser != nil){
                self.errorNotice("用户已经注册")
            self.mailText!.becomeFirstResponder()
                self.doneButton?.enabled = false
            }
            else{
                user.saveInBackgroundWithBlock({ (succeed, e) -> Void in
                    if succeed{
                        self.successNotice("恭喜，注册成功")
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                    else{
                        self.errorNotice("网络不好")
                    }
                })
            }
        }
    }
}
