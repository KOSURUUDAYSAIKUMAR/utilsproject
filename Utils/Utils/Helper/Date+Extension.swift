//
//  Date+Extension.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 21/12/23.
//

import UIKit

class Date_Extension: NSObject {

}

extension Date {
    func convertToString(formate : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        dateFormatter.timeZone =  NSTimeZone.system
        let dateString = dateFormatter.string(from: self as Date)
        return dateString
    }
    
    func convertToString(formate : DateFormate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone =  NSTimeZone.system
       // dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = formate.rawValue
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

extension DateFormate {
    static func filterCases(startingWith prefix: String) -> [String] {
        let filteredCases = DateFormate.allCases
            .filter { $0.rawValue.lowercased().starts(with: prefix.lowercased()) }
            .map { $0.rawValue }
        return filteredCases
    }
}

extension DateFormate {
    static func filterCases(startingWith prefix: String, caseSensitive: Bool = false) -> [String] {
        let filteredCases = DateFormate.allCases
            .filter {
                if caseSensitive {
                    return $0.rawValue.lowercased().hasPrefix(prefix.lowercased())
                } else {
                    return $0.rawValue.hasPrefix(prefix)
                }
            }
            .map { $0.rawValue }
        return filteredCases
    }
}

extension DateFormate {
    static var allCasesString: String {
        return allCases.map { $0.rawValue }.joined(separator: ", ")
    }
}
