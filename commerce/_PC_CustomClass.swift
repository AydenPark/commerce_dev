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

public class rsCBuys {
    var _suid: String?
    var _iuid: String?
    var _name: String?
    var _count: String?
    var _price: String?
}

public class User {
    private var suid: String?
    private var name: String?
    private var phone: String?
    private var address: String?
    
    public func initData() {
        self.suid = "";
        self.name = "";
        self.phone = "";
        self.address = "";
    }
    
    public func User(suid: String, name: String, phone: String, address: String) {
        self.suid = suid;
        self.name = name;
        self.phone = phone;
        self.address = address;
    }
    
    public func userPrefsInit() {
        let userInfo: Dictionary<NSObject, AnyObject> = [
            "suid": self.suid!,
            "name": self.name!,
            "phone": self.phone!,
            "address": self.address!]
        prefs.setObject(userInfo, forKey: "USER_INFO")
        prefs.synchronize()
    }
    
    public func setUserPrefs() {
        let userInfo: Dictionary<NSObject, AnyObject> = [
        "suid": self.suid!,
        "name": self.name!,
        "phone": self.phone!,
        "address": self.address!]
        prefs.setObject(userInfo, forKey: "USER_INFO")
        prefs.synchronize()
    }
    
    public func getUserPrefs() {
        var userInfo: Dictionary = prefs.dictionaryForKey("USER_INFO")!
        if userInfo.count > 0 {
            setSUID(userInfo["suid"] as! String)
            setName(userInfo["name"] as! String)
            setPhone(userInfo["phone"] as! String)
            setAddress(userInfo["address"] as! String)
        }
    }
    
    public func getSUID()->String { return suid! }
    public func setSUID(suid: String) { self.suid = suid }
    
    public func getName()->String { return name! }
    public func setName(name: String) { self.name = name }
    
    public func getPhone()->String { return phone! }
    public func setPhone(phone: String) { self.phone = phone }
    
    public func getAddress()->String { return address! }
    public func setAddress(address: String) { self.address = address }
}

func SendToDB(datas: [rsCBuys]) {
    for data in datas {
        print(data._name)
        print(data._count)
    }
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
    
    var results: NSArray = []
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

extension UITextField {
    func setTextLeftPadding(left:CGFloat) {
        let leftView:UIView = UIView(frame: CGRectMake(0, 0, left, 1))
        leftView.backgroundColor = UIColor.clearColor()
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewMode.Always;
    }
}

extension String
{
    func substringFromIndex(index: Int) -> String
    {
        if (index < 0 || index > self.characters.count)
        {
            print("index \(index) out of bounds")
            return ""
        }
        return self.substringFromIndex(self.startIndex.advancedBy(index))
    }
    
    func substringToIndex(index: Int) -> String
    {
        if (index < 0 || index > self.characters.count)
        {
            print("index \(index) out of bounds")
            return ""
        }
        return self.substringToIndex(self.startIndex.advancedBy(index))
    }
    
    func substringWithRange(start: Int, end: Int) -> String
    {
        if (start < 0 || start > self.characters.count)
        {
            print("start index \(start) out of bounds")
            return ""
        }
        else if end < 0 || end > self.characters.count
        {
            print("end index \(end) out of bounds")
            return ""
        }
        let range = Range(start: self.startIndex.advancedBy(start), end: self.startIndex.advancedBy(end))
        return self.substringWithRange(range)
    }
    
    func substringWithRange(start: Int, location: Int) -> String
    {
        if (start < 0 || start > self.characters.count)
        {
            print("start index \(start) out of bounds")
            return ""
        }
        else if location < 0 || start + location > self.characters.count
        {
            print("end index \(start + location) out of bounds")
            return ""
        }
        let range = Range(start: self.startIndex.advancedBy(start), end: self.startIndex.advancedBy(start + location))
        return self.substringWithRange(range)
    }
}

protocol SubTagDispDelegate {
    // 선택한 아이템의 정보를 전달 하기 위한 델리게이트 메소드
    func tappedItemInfo(itemData: rsCItems)
}