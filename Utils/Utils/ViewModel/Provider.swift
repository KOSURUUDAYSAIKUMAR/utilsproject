//
//  Provider.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 19/12/23.
//

import UIKit

class Provider: NSObject {
    var currentList: [DataItem] = []
    
    static let shared = Provider()
    
    func addDataItem(withTitle title: String, list:[String]) {
        let item = DataItem(isExpand: false, title: title, list: list)
        self.currentList.append(item)
    }
    
    func ideaListItems() -> [DataItem] {
        let result = self.currentList.map({$0})
        return result
    }
}
