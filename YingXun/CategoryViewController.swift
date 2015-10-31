//
//  CategoryViewController.swift
//  YingXun
//
//  Created by wjl on 15/10/26.
//  Copyright © 2015年 麦扣. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    private var collView: UICollectionView!

    private var categoryData = [CategoryData]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setCollectionView()
        navigationItem.title = "分类推荐"
      
        let data1 = CategoryData(imageView: "catogory01.png", categoryName: "喜剧")
        let data2 = CategoryData(imageView: "catogory06.png", categoryName: "喜剧")
        let data3 = CategoryData(imageView: "catogory05.png", categoryName: "喜剧")
        let data4 = CategoryData(imageView: "catogory04.png", categoryName: "喜剧")
        let data5 = CategoryData(imageView: "catogory03.png", categoryName: "喜剧")
        let data6 = CategoryData(imageView: "catogory02.png", categoryName: "喜剧")
        categoryData = [data1,data2,data3,data4,data5,data6,data1,data2,data3,data4,data5,data6,data1,data2,data3,data4,data5,data6]
    }
    
    private func setCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 10
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        let itemH:CGFloat = 80
        var itemW = (Width - 4 * margin) / 3 - 2
        if Width > 375 {
            itemW -= 3
        }
        layout.itemSize = CGSizeMake(itemW, itemH)
        
        collView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collView.delegate = self
        collView.dataSource = self
        collView.backgroundColor = UIColor.whiteColor()
        collView.alwaysBounceVertical = true

        collView.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        collView.showsHorizontalScrollIndicator = false
        collView.showsVerticalScrollIndicator = false
        view.addSubview(collView)
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return categoryData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "categoryCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CategoryCell
        cell.nameLabel.text = categoryData[indexPath.row].categoryName
        cell.imgView.image = UIImage(named: categoryData[indexPath.row].imageView)
        
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let vc = ListVideoController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
