//
//  ListVideoController.swift
//  VideoTaste
//
//  Created by wjl on 15/10/17.
//  Copyright © 2015年 wjl. All rights reserved.
//

import UIKit

class ListVideoController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    var collectionView : UICollectionView?
    let imgs = ["catogory02.png","catogory05.png","catogory04.png","catogory03.png","catogory03.png"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置collectionView的layOut
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake((self.view?.frame.width)!, (self.view?.frame.height)! * 0.25)
        collectionView = UICollectionView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), collectionViewLayout: layout)
       
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        self.view.addSubview(collectionView!)
        
        //注册一个cell
        collectionView! .registerClass(ListVideoCell.self, forCellWithReuseIdentifier:"listCell")
    }

     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imgs.count
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "listCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)as! ListVideoCell
        cell.imgView?.image = UIImage(named:imgs[indexPath.row])
   
        return cell
    }


    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let vc = DetailViewController()
        vc.key = "北京遇上西雅图"
        self.navigationController?.pushViewController(vc, animated: true)
    }


}
