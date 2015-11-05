//
//  CustomClass.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 3..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit

public class rsCItems {
    var _image: String?
    var _name: String?
    var _origin: String?
    var _price: String?
}

public class rsCEvent {
    struct total {
        var count: String?
    }
    struct category {
        var count: [String]?
        var title: [String]?
        var idx: [String]?
    }
    struct item {
        var iuid: [String]?
    }
    
    var _total: total?
    var _category: category?
    var _item: item?
}

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension String {
    var length: Int { return characters.count    }  // Swift 2.0
}