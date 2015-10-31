//
//  DetailViewController.swift
//  VideoTaste
//
//  Created by wjl on 15/10/5.
//  Copyright © 2015年 wjl. All rights reserved.
//

import UIKit
import WebKit
class DetailViewController: UIViewController,UIScrollViewDelegate {

    var key:String?
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "推荐详情"
        
        self.webView = WKWebView(frame: CGRectZero)
        self.view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false

        let height = NSLayoutConstraint(item: webView, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0)
        view.addConstraints([height, width])
        //为详细内容进行赋值
        self.loadDataSource()
    }
    //为WebView进行内容获取
    func loadDataSource(){
        
        let urlRe: NSURLRequest = refreshDetailData(key!)
        webView.loadRequest(urlRe)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    

}
