//
//  UpdatefromDB.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 4..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class Items_DB {
    func updateItemsData() {
        var itemsDataDic = [NSDictionary]()
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let itemsContext:NSManagedObjectContext = app.managedObjectContext
        var itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        var itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)
        g_pc_CHD.deleteContext("Item_Info", context: itemsContext)
        
        itemsDataDic = (g_test_Items?.initData())!
        
        NSLog("ItemsData_Rev_From_DB : %d", itemsDataDic.count)
        
        for item in itemsDataDic {
            itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
            itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)
            
            itemsData.iuid = item.valueForKey("iuid") as? String
            itemsData.name = item.valueForKey("name") as? String
            itemsData.purchase = item.valueForKey("purchase") as? String
            itemsData.selling = item.valueForKey("selling") as? String
            itemsData.image = item.valueForKey("image") as? String
            
            let eventDataDic = item.valueForKey("event") as? NSDictionary
            for n in 0...eventDataDic!["euid"]!.count-1 {
                let event = NSEntityDescription.insertNewObjectForEntityForName("Item_Event", inManagedObjectContext: itemsContext) as! Item_Event
                event.euid = eventDataDic!["euid"]![n] as? String
                event.name = eventDataDic!["name"]![n] as? String
                itemsData.addEvent(event)
            }
            
            let tagDataDic = item.valueForKey("tag") as! NSDictionary
            for n in 0...tagDataDic["tuid"]!.count-1 {
                let tag = NSEntityDescription.insertNewObjectForEntityForName("Item_Tag", inManagedObjectContext: itemsContext) as! Item_Tag
                tag.tuid = tagDataDic["tuid"]![n] as? String
                tag.name = tagDataDic["name"]![n] as? String
                itemsData.addTag(tag)
            }
            g_pc_CHD.saveContext(itemsContext)
        }

        //Relationships의 내용을 얻어오는 방법
//        let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Info")
//        request.returnsObjectsAsFaults = false
//        
//        var error: NSError?
//        var results: NSArray = []
//        
//        do {
//            results = try itemsContext.executeFetchRequest(request)
//            // success ...
//            for item in results {
//                let tmp = item as! Item_Info
//                for event in tmp.item_event! {
//                    print(event.valueForKey("euid"))
//                }
//            }
//        } catch let error as NSError {
//            // failure
//            print("Fetch failed: \(error.localizedDescription)")
//        }
    }
    
    func updateEventsData() {
        var eventsDataDic = NSDictionary()
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let eventsContext:NSManagedObjectContext = app.managedObjectContext
        var eventsDescription = NSEntityDescription.entityForName("Item_Event", inManagedObjectContext: eventsContext)
        var eventsData = Item_Event(entity: eventsDescription!, insertIntoManagedObjectContext: eventsContext)
        g_pc_CHD.deleteContext("Item_Event", context: eventsContext)
        
        eventsDataDic = g_test_ItemsEvent!.initData()
        
        NSLog("EventsData_Rev_From_DB : %d", eventsDataDic["euid"]!.count)
        
        for n in 0...eventsDataDic["euid"]!.count-1 {
            eventsDescription = NSEntityDescription.entityForName("Item_Event", inManagedObjectContext: eventsContext)
            eventsData = Item_Event(entity: eventsDescription!, insertIntoManagedObjectContext: eventsContext)
            eventsData.euid = eventsDataDic["euid"]![n] as? String
            eventsData.name = eventsDataDic["name"]![n] as? String
            g_pc_CHD.saveContext(eventsContext)
        }
    }
    
    func updateTagsData() {
        var tagsDataDic = NSDictionary()
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let tagsContext:NSManagedObjectContext = app.managedObjectContext
        var tagsDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagsContext)
        var tagsData = Item_Tag(entity: tagsDescription!, insertIntoManagedObjectContext: tagsContext)
        g_pc_CHD.deleteContext("Item_Tag", context: tagsContext)
        
        tagsDataDic = g_test_ItemsTag!.initData()
        
        NSLog("TagsData_Rev_From_DB : %d", tagsDataDic["tuid"]!.count)
        
        for n in 0...tagsDataDic["tuid"]!.count-1 {
            tagsDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagsContext)
            tagsData = Item_Tag(entity: tagsDescription!, insertIntoManagedObjectContext: tagsContext)
            tagsData.tuid = tagsDataDic["tuid"]![n] as? String
            tagsData.name = tagsDataDic["name"]![n] as? String
            g_pc_CHD.saveContext(tagsContext)
        }
        
        //탭바 라벨 추가(탭 아이디가 mt로 시작되는 태그만)
        let fReq: NSFetchRequest = NSFetchRequest(entityName: "Item_Tag")
        fReq.predicate = NSPredicate(format:"tuid CONTAINS 'mt'")
        for result in (try! tagsContext.executeFetchRequest(fReq)) as! [Item_Tag] {
            g_rs_Strings._tab_text.append(result.name)
        }
        
    }
}
