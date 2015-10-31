//
//  CheckInputs.swift
//  VideoTaste
//
//  Created by wjl on 15/10/20.
//  Copyright © 2015年 wjl. All rights reserved.
//

import Foundation

struct CheckInputs: OptionSetType {
    let rawValue: Int
    static let mail = CheckInputs(rawValue: 1)
    static let user = CheckInputs(rawValue: 1 << 1)
    static let pass = CheckInputs(rawValue: 1 << 2)
}

extension CheckInputs{
    
     func isAllOk()->Bool{
        //这里表示共有三个属性
        let count = 3
        //表示已经填的必填项的个数
        var found = 0
        //迭代来判断
        for time in 0..<count{
            
            if self.contains(CheckInputs(rawValue:1<<time)){
                found++
            }
        }
        //如果三个都已经填，那么返回true
        return found == count
    }
}