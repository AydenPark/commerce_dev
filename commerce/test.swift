//
//  test.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 4..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class testItems {
    func initData() -> [NSDictionary] {
        var eventData = NSDictionary()
        var tagData = NSDictionary()
        var itemsData = [NSDictionary]()
        
        eventData = ["euid" : ["ev001", "ev002"], "name" : ["특가상품", "인기상품"]]
        tagData = ["tuid" : ["mt001", "st001"], "name" : ["신선식품", "과일"]]
        itemsData.append(["iuid" : "frt001", "name" : "사과", "selling" : "5000", "purchase" : "7000", "image" : "img_apple", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : [""], "name" : [""]]
        tagData = ["tuid" : ["mt001", "st001"], "name" : ["신선식품", "과일"]]
        itemsData.append(["iuid" : "frt002", "name" : "오렌지", "selling" : "5000", "purchase" : "7000", "image" : "img_orange", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev001"], "name" : ["특가상품"]]
        tagData = ["tuid" : ["mt001", "st001"], "name" : ["신선식품", "과일"]]
        itemsData.append(["iuid" : "frt003", "name" : "단감", "selling" : "5000", "purchase" : "7000", "image" : "img_persimmon", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev002"], "name" : ["인기상품"]]
        tagData = ["tuid" : ["mt001", "st001"], "name" : ["신선식품", "과일"]]
        itemsData.append(["iuid" : "frt004", "name" : "포도", "selling" : "5000", "purchase" : "7000", "image" : "img_grape", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev002"], "name" : ["인기상품"]]
        tagData = ["tuid" : ["mt001", "st002"], "name" : ["신선식품", "채소"]]
        itemsData.append(["iuid" : "vtb001", "name" : "고구마", "selling" : "5000", "purchase" : "7000", "image" : "img_spotato", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev001", "ev002"], "name" : ["특가상품", "인기상품"]]
        tagData = ["tuid" : ["mt001", "st002"], "name" : ["신선식품", "채소"]]
        itemsData.append(["iuid" : "vtb002", "name" : "감자", "selling" : "5000", "purchase" : "7000", "image" : "img_potato", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev001"], "name" : ["특가상품"]]
        tagData = ["tuid" : ["mt001", "st002"], "name" : ["신선식품", "채소"]]
        itemsData.append(["iuid" : "vtb003", "name" : "당근", "selling" : "5000", "purchase" : "7000", "image" : "img_carrot", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev001"], "name" : ["특가상품"]]
        tagData = ["tuid" : ["mt001", "st002"], "name" : ["신선식품", "채소"]]
        itemsData.append(["iuid" : "vtb004", "name" : "오이", "selling" : "5000", "purchase" : "7000", "image" : "img_cucumber", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : [""], "name" : [""]]
        tagData = ["tuid" : ["mt001", "st003"], "name" : ["신선식품", "축산"]]
        itemsData.append(["iuid" : "lsk001", "name" : "계란", "selling" : "5000", "purchase" : "7000", "image" : "img_egg", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : [""], "name" : [""]]
        tagData = ["tuid" : ["mt002", "st004"], "name" : ["기타식품", "건어물"]]
        itemsData.append(["iuid" : "drf001", "name" : "김", "selling" : "5000", "purchase" : "7000", "image" : "img_laver", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : [""], "name" : [""]]
        tagData = ["tuid" : ["mt002", "st006"], "name" : ["기타식품", "잡곡"]]
        itemsData.append(["iuid" : "grn001", "name" : "쌀", "selling" : "5000", "purchase" : "7000", "image" : "img_rice", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : [""], "name" : [""]]
        tagData = ["tuid" : ["mt099", "st091"], "name" : ["전용식품", "해독주스"]]
        itemsData.append(["iuid" : "dtx001", "name" : "효소 다이어트", "selling" : "5000", "purchase" : "", "image" : "img_detox1", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : [""], "name" : [""]]
        tagData = ["tuid" : ["mt099", "st092"], "name" : ["전용식품", "샐러드"]]
        itemsData.append(["iuid" : "sld001", "name" : "아침을 위한 간편 샐러드", "selling" : "5000", "purchase" : "", "image" : "img_salad1", "tag" : tagData, "event" : eventData])
        
        return itemsData
    }
}

public class testItemsTag  {
    func initData() -> NSDictionary {
        var tagData = NSDictionary()

        tagData = ["tuid" : ["mt001", "mt002", "mt099", "st001", "st002", "st003", "st004", "st005", "st006", "st091", "st092" ], "name" : ["신선식품", "기타식품", "전용식품", "과일", "채소", "축산", "건어물", "수산물", "잡곡", "해독주스", "샐러드"]]
        
        return tagData
    }
}
public class testItemsEvent {
    func initData() -> NSDictionary {
        var eventData = NSDictionary()
        
        eventData = ["euid" : ["ev001", "ev002"], "name" : ["특가상품", "인기상품"]]
       // eventData = ["euid" : ["ev001"], "name" : ["특가상품"]]
       // eventData = ["euid" : [""], "name" : [""]]
        return eventData
    }
}