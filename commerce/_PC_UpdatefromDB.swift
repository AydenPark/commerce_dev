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
    func updateData() {
        var ItemsDataDic = [NSDictionary]()
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let itemsContext:NSManagedObjectContext = app.managedObjectContext
        var itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        var itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)
        pc_CHD?.deleteContext("Item_Info", context: itemsContext)
        
        ItemsDataDic = (test_Items?.initData())!
        
        NSLog("ItemsData_Rev_From_DB : %d", ItemsDataDic.count)
        
        for item in ItemsDataDic {
            itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
            itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)
            
            itemsData.iuid = item.valueForKey("iuid") as! String
            itemsData.name = item.valueForKey("name") as! String
            itemsData.purchase = item.valueForKey("purchase") as! String
            itemsData.selling = item.valueForKey("selling") as! String
            itemsData.image = item.valueForKey("image") as! String
            
            var eventDataDic = item.valueForKey("event") as! NSDictionary
            for n in 0...eventDataDic["euid"]!.count-1 {
                let event = NSEntityDescription.insertNewObjectForEntityForName("Item_Event", inManagedObjectContext: itemsContext) as! Item_Event
                event.euid = eventDataDic["euid"]![n] as! String
                event.name = eventDataDic["name"]![n] as! String
                itemsData.addEvent(event)
            }
            
            var tagDataDic = item.valueForKey("tag") as! NSDictionary
            for n in 0...tagDataDic["tuid"]!.count-1 {
                let tag = NSEntityDescription.insertNewObjectForEntityForName("Item_Tag", inManagedObjectContext: itemsContext) as! Item_Tag
                tag.tuid = tagDataDic["tuid"]![n] as! String
                tag.name = tagDataDic["name"]![n] as! String
                itemsData.addTag(tag)
            }
            pc_CHD?.saveContext(itemsContext)
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
}
