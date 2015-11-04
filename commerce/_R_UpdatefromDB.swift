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
    
}

public class Event_DB {
    
    func update_EV_Total(eventData: rsCEvent) {
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let totalContext:NSManagedObjectContext = app.managedObjectContext
        let totalDescription = NSEntityDescription.entityForName("Event_Total", inManagedObjectContext: totalContext)
        var totalData = Event_Total(entity: totalDescription!, insertIntoManagedObjectContext: totalContext)
        
        let categoryContext:NSManagedObjectContext = app.managedObjectContext
        let categoryDescription = NSEntityDescription.entityForName("Event_Category", inManagedObjectContext: categoryContext)
        var categoryData = Event_Category(entity: categoryDescription!, insertIntoManagedObjectContext: categoryContext)
        
        let itemContext:NSManagedObjectContext = app.managedObjectContext
        let itemDescription = NSEntityDescription.entityForName("Event_Item", inManagedObjectContext: itemContext)
        var itemData = Event_Item(entity: itemDescription!, insertIntoManagedObjectContext: itemContext)
        
        totalData.count = eventData._total?.count
        do {
            try totalContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        for n in 0...(eventData._category?.count)!.count {
            categoryData.count = eventData._category?.count![n]
            categoryData.title = eventData._category?.title![n]
            categoryData.idx = eventData._category?.idx![n]
            do {
                try totalContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
        
        for item in (eventData._item?.iuid)! {
            itemData.iuid = item
            do {
                try totalContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}
