//
//  DataItem.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 19/12/23.
//

import UIKit

struct DataItem: Equatable {
    var isExpand: Bool = false
    var title: String
    var dataList:[String] = []
    
    init(isExpand:Bool = false, title:String, list:[String]) {
        self.isExpand = isExpand
        self.title = title
        self.dataList = list
    }
}

func ==(lhs: DataItem, rhs: DataItem) -> Bool {
    return lhs.title == rhs.title
}
