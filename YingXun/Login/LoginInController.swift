//
//  LoginInController.swift
//  VideoLogin
//
//  Created by wjl on 15/10/17.
//  Copyright © 2015年 wjl. All rights reserved.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius:CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
    }
}

class LoginInController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginMail: UITextField!
    
    @IBOutlet weak var signIn: UIButton!

    @IBAction func loginIn(sender: AnyObject) {
        
        guard loginMail == nil  else{
            self.errorNotice("请输入正确信息")
            return
        }
        let query = AVQuery(className: "AllUser")
        query.whereKey("mail", equalTo: self.loginMail.text)
        query.getFirstObjectInBackgroundWithBlock { (isUser, e) -> Void in

            let localData = isUser!.valueForKey("localData")
            //let leanMail = localData?.valueForKey("mail") as! String
            let leanPass = localData?.valueForKey("password") as! String
            guard isUser != nil else{
                self.loginMail.becomeFirstResponder()
                self.errorNotice("用户不存在")
                return
            }
            guard self.password.text == leanPass else{
                self.loginMail.becomeFirstResponder()
                self.errorNotice("密码不正确")
                return
            }
        }
        
    }
    init() {
        super.init(nibName: "LoginInView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: "LoginInView", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "登录"
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(customView: <#T##UIView#>)
        
        signIn.addTarget(self, action: "signInButton", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func signInButton(){
        let reg = RegViewController()
        navigationController?.pushViewController(reg, animated: true)
    }
}





