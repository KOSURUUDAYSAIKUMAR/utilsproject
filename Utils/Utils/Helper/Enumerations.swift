//
//  Enumerations.swift
//  Utils
//
//  Created by Kosuru Uday Saikumar on 21/12/23.
//

import UIKit

enum DateFormate:String, CaseIterable {
    case Format1 = "dd MMM yyyy HH:mm zzz"
    case Format2 = "dd MMM yyyy HH:mm"
    case Format3 = "yyyy-MM-dd HH:mm:ss zzz"
    case Format4 = "yyyy-MM-dd HH:mm:ss"
    case Format5 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case Format6 = "MMM dd, yyyy" //July 3, 2017
    case Format7 = "MMM dd" // Jul 21
    case Format8 = "MMM yyyy" // Jun 2018
    case Format9 = "hh:mm a, MMM dd" // 02:45 PM, Jun 4
    case Format10 = "hh:mm a" // 02:45 PM
    case Format11 = "MM/dd/yyyy hh:mm:ss a"
    case Format12 = "yyyy-MM-dd"
    case Format13 = "yyyy-MM-dd'T'HH:mm:ss"
    case Format14 = "MM-dd-yyyy"
    case Format15 = "HH:mm:ss"
    case Format16 = "HH:mm"
    case Format17 = "MM/yyyy"
    case Format18 = "MM/yy"
    case Format19 = "MM/dd/yy hh:mm a" //09/14/20 11:27 AM
    case Format20 = "MM/dd/yy" //"11/14/21"
    case Format21 = "MM-dd-yy hh:mm a" //09/14/20 11:27 AM
    case Format22 = "HHmmss"
    case Format23 = "yyMM"
    case Format24 = "dd-MM-yy"
    case Format25 = "dd-MM-yyyy"
}
