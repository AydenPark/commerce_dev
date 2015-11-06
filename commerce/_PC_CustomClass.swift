//
//  CustomClass.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 3..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class rsCItems {
    var _iuid: String?
    var _image: String?
    var _name: String?
    var _purchase: String?
    var _selling: String?
    var _tag:[String] = []
}

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func MatchingTagViaIUID(iuid: String) -> [String] {
    var tag:[String] = []
    
    //태그에 해당하는 아이템 필터
    let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let context:NSManagedObjectContext = app.managedObjectContext
    let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Info")
    request.returnsObjectsAsFaults = false
    
    var error: NSError?
    var results: NSArray = []
    var itemInfo = [rsCItems]()
    do {
        results = try context.executeFetchRequest(request)
        // success ...
        for item in results {
            let tmp = item as! Item_Info
            for item_tag in tmp.item_tag! {
                if iuid.isEqual(item.valueForKey("iuid")) {
                    tag.append(item_tag.valueForKey("tuid") as! String)
                }
            }
        }
        
    } catch let error as NSError {
        // failure
        print("Fetch failed: \(error.localizedDescription)")
    }
    
    return tag
}

extension String {
    var length: Int { return characters.count    }  // Swift 2.0
}