//
//  DetailTableViewCell.swift
//  YingXun
//
//  Created by wjl on 15/10/26.
//  Copyright © 2015年 麦扣. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    func showHomeValue(data: HomeData){
        nameLabel.text = data.nameLabel
        titleLabel.text = data.titleLabel
        timeLabel.text = data.timeLabel
        imgView.image = UIImage(data: data.imageView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        
    }
    
}
