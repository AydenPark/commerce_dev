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
        itemsData.append(["iuid" : "fr001", "name" : "사과", "selling" : "5000", "purchase" : "7000", "image" : "img_apple", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : [""], "name" : [""]]
        tagData = ["tuid" : ["mt001", "st001"], "name" : ["신선식품", "과일"]]
        itemsData.append(["iuid" : "fr002", "name" : "오렌지", "selling" : "5000", "purchase" : "7000", "image" : "img_orange", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev001"], "name" : ["특가상품"]]
        tagData = ["tuid" : ["mt001", "st001"], "name" : ["신선식품", "과일"]]
        itemsData.append(["iuid" : "fr003", "name" : "단감", "selling" : "5000", "purchase" : "7000", "image" : "img_persimmon", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev002"], "name" : ["인기상품"]]
        tagData = ["tuid" : ["mt001", "st001"], "name" : ["신선식품", "과일"]]
        itemsData.append(["iuid" : "fr004", "name" : "포도", "selling" : "5000", "purchase" : "7000", "image" : "img_grape", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev002"], "name" : ["인기상품"]]
        tagData = ["tuid" : ["mt001", "st002"], "name" : ["신선식품", "채소"]]
        itemsData.append(["iuid" : "vt001", "name" : "고구마", "selling" : "5000", "purchase" : "7000", "image" : "img_spotato", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev001", "ev002"], "name" : ["특가상품", "인기상품"]]
        tagData = ["tuid" : ["mt001", "st002"], "name" : ["신선식품", "채소"]]
        itemsData.append(["iuid" : "vt002", "name" : "감자", "selling" : "5000", "purchase" : "7000", "image" : "img_potato", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev001"], "name" : ["특가상품"]]
        tagData = ["tuid" : ["mt001", "st002"], "name" : ["신선식품", "채소"]]
        itemsData.append(["iuid" : "vt003", "name" : "당근", "selling" : "5000", "purchase" : "7000", "image" : "img_carrot", "tag" : tagData, "event" : eventData])
        
        eventData = ["euid" : ["ev001"], "name" : ["특가상품"]]
        tagData = ["tuid" : ["mt001", "st002"], "name" : ["신선식품", "채소"]]
        itemsData.append(["iuid" : "vt004", "name" : "오이", "selling" : "5000", "purchase" : "7000", "image" : "img_cucumber", "tag" : tagData, "event" : eventData])
        
        return itemsData
    }
}
        /*
        
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let itemsContext:NSManagedObjectContext = app.managedObjectContext
        var itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        var itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)
        
        let deleteRequest = NSFetchRequest(entityName: "Item_Info")
        do {
            let deleteList = try itemsContext.executeFetchRequest(deleteRequest)
            // success ...
            for bas: AnyObject in deleteList
            {
                itemsContext.deleteObject(bas as! NSManagedObject)
            }
            do { try itemsContext.save() }
            catch { fatalError("Failure to save context: \(error)") }
            
        } catch let error as NSError { print("Fetch failed: \(error.localizedDescription)") }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "fr001"
        itemsData.name = "사과"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"

        do { try itemsContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "fr002"
        itemsData.name = "포도"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do { try itemsContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)
        
        itemsData.iuid = "fr003"
        itemsData.name = "단감"
        itemsData.price = "6000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do { try itemsContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "fr004"
        itemsData.name = "귤"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do { try itemsContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "vt001"
        itemsData.name = "고구마"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do { try itemsContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "vt002"
        itemsData.name = "감자"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do { try itemsContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "vt003"
        itemsData.name = "당근"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do { try itemsContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "vt004"
        itemsData.name = "오이"
        itemsData.price = "5000"
        itemsData.origin = "6000"
        itemsData.image = "fr_potato"
        
        do { try itemsContext.save() }
        catch { fatalError("Failure to save context: \(error)") }*/

public class testItemsTag {
    func initData() {
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let tagContext:NSManagedObjectContext = app.managedObjectContext
        var tagDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagContext)
        var tagData = Item_Tag(entity: tagDescription!, insertIntoManagedObjectContext: tagContext)
        
        let deleteRequest = NSFetchRequest(entityName: "Item_Tag")
        do {
            let deleteList = try tagContext.executeFetchRequest(deleteRequest)
            // success ...
            for bas: AnyObject in deleteList
            {
                tagContext.deleteObject(bas as! NSManagedObject)
            }
            do { try tagContext.save() }
            catch { fatalError("Failure to save context: \(error)") }
            
        } catch let error as NSError { print("Fetch failed: \(error.localizedDescription)") }
        
        tagDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagContext)
        tagData = Item_Tag(entity: tagDescription!, insertIntoManagedObjectContext: tagContext)
        
        tagData.tuid = "mt001"
        tagData.name = "신선식품"
        
        do { try tagContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        tagDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagContext)
        tagData = Item_Tag(entity: tagDescription!, insertIntoManagedObjectContext: tagContext)
        
        tagData.tuid = "mt002"
        tagData.name = "기타식품"
        
        do { try tagContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        tagDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagContext)
        tagData = Item_Tag(entity: tagDescription!, insertIntoManagedObjectContext: tagContext)
        
        tagData.tuid = "mt003"
        tagData.name = "전용식품"
        
        do { try tagContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        tagDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagContext)
        tagData = Item_Tag(entity: tagDescription!, insertIntoManagedObjectContext: tagContext)
        
        tagData.tuid = "st001"
        tagData.name = "과일"
        
        do { try tagContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        tagDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagContext)
        tagData = Item_Tag(entity: tagDescription!, insertIntoManagedObjectContext: tagContext)
        
        tagData.tuid = "st002"
        tagData.name = "채소"
        
        do { try tagContext.save() }
        catch { fatalError("Failure to save context: \(error)") }

        
        tagDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagContext)
        tagData = Item_Tag(entity: tagDescription!, insertIntoManagedObjectContext: tagContext)
        
        tagData.tuid = "st003"
        tagData.name = "축산"
        
        do { try tagContext.save() }
        catch { fatalError("Failure to save context: \(error)") }

        
        tagDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagContext)
        tagData = Item_Tag(entity: tagDescription!, insertIntoManagedObjectContext: tagContext)
        
        tagData.tuid = "st004"
        tagData.name = "건어물"
        
        do { try tagContext.save() }
        catch { fatalError("Failure to save context: \(error)") }

        
        tagDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagContext)
        tagData = Item_Tag(entity: tagDescription!, insertIntoManagedObjectContext: tagContext)
        
        tagData.tuid = "st005"
        tagData.name = "수산물"
        
        do { try tagContext.save() }
        catch { fatalError("Failure to save context: \(error)") }

        
        tagDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagContext)
        tagData = Item_Tag(entity: tagDescription!, insertIntoManagedObjectContext: tagContext)
        
        tagData.tuid = "st006"
        tagData.name = "잡곡"
        
        do { try tagContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
    }
}
public class testItemsEvent {
    func initData() {
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let eventContext:NSManagedObjectContext = app.managedObjectContext
        var eventDescription = NSEntityDescription.entityForName("Item_Event", inManagedObjectContext: eventContext)
        var eventData = Item_Event(entity: eventDescription!, insertIntoManagedObjectContext: eventContext)
        
        let deleteRequest = NSFetchRequest(entityName: "Item_Event")
        do {
            let deleteList = try eventContext.executeFetchRequest(deleteRequest)
            // success ...
            for bas: AnyObject in deleteList
            {
                eventContext.deleteObject(bas as! NSManagedObject)
            }
            do { try eventContext.save() }
            catch { fatalError("Failure to save context: \(error)") }
            
        } catch let error as NSError { print("Fetch failed: \(error.localizedDescription)") }
    
        eventDescription = NSEntityDescription.entityForName("Item_Event", inManagedObjectContext: eventContext)
        eventData = Item_Event(entity: eventDescription!, insertIntoManagedObjectContext: eventContext)

        eventData.euid = "ev001"
        eventData.name = "특가상품"
        
        do { try eventContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        eventDescription = NSEntityDescription.entityForName("Item_Event", inManagedObjectContext: eventContext)
        eventData = Item_Event(entity: eventDescription!, insertIntoManagedObjectContext: eventContext)
        
        eventData.euid = "ev002"
        eventData.name = "인기상품"
        
        do { try eventContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
    }
}

public class testItemsJoin {
    func initData() {
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let joinContext:NSManagedObjectContext = app.managedObjectContext
        var joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        var joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)

        let deleteRequest = NSFetchRequest(entityName: "Item_Join")
        do {
            let deleteList = try joinContext.executeFetchRequest(deleteRequest)
            // success ...
            for bas: AnyObject in deleteList
            {
                joinContext.deleteObject(bas as! NSManagedObject)
            }
            do { try joinContext.save() }
            catch { fatalError("Failure to save context: \(error)") }
            
        } catch let error as NSError { print("Fetch failed: \(error.localizedDescription)") }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.iuid = "fr001"
        joinData.euid = "ev001"
        
        do { try joinContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev001"
        joinData.iuid = "fr003"
        
        do { try joinContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev002"
        joinData.iuid = "fr003"
        
        do { try joinContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev002"
        joinData.iuid = "vt001"
        
        do { try joinContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev002"
        joinData.iuid = "vt003"
        
        do { try joinContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev002"
        joinData.iuid = "vt004"
        
        do { try joinContext.save() }
        catch { fatalError("Failure to save context: \(error)") }
    }
}
