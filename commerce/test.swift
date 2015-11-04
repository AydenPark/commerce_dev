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
    func initData() {
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
            do {
                try itemsContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "fr001"
        itemsData.name = "사과"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"

        do {
            try itemsContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "fr002"
        itemsData.name = "포도"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do {
            try itemsContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)
        
        itemsData.iuid = "fr003"
        itemsData.name = "단감"
        itemsData.price = "6000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do {
            try itemsContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "fr004"
        itemsData.name = "귤"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do {
            try itemsContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "vt001"
        itemsData.name = "고구마"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do {
            try itemsContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "vt002"
        itemsData.name = "감자"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do {
            try itemsContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "vt003"
        itemsData.name = "당근"
        itemsData.price = "5000"
        itemsData.origin = "7000"
        itemsData.image = "fr_potato"
        
        do {
            try itemsContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
        itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)

        itemsData.iuid = "vt004"
        itemsData.name = "오이"
        itemsData.price = "5000"
        itemsData.origin = "6000"
        itemsData.image = "fr_potato"
        
        do {
            try itemsContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
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
            do {
                try eventContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    
        eventDescription = NSEntityDescription.entityForName("Item_Event", inManagedObjectContext: eventContext)
        eventData = Item_Event(entity: eventDescription!, insertIntoManagedObjectContext: eventContext)

        eventData.euid = "ev001"
        eventData.title = "특가상품"
        
        do {
            try eventContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        eventDescription = NSEntityDescription.entityForName("Item_Event", inManagedObjectContext: eventContext)
        eventData = Item_Event(entity: eventDescription!, insertIntoManagedObjectContext: eventContext)
        
        eventData.euid = "ev002"
        eventData.title = "인기상품"
        
        do {
            try eventContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
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
            do {
                try joinContext.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev001"
        joinData.iuid = "fr001"
        
        do {
            try joinContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev001"
        joinData.iuid = "fr003"
        
        do {
            try joinContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev002"
        joinData.iuid = "fr003"
        
        do {
            try joinContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev002"
        joinData.iuid = "vt001"
        
        do {
            try joinContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev002"
        joinData.iuid = "vt003"
        
        do {
            try joinContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        joinDescription = NSEntityDescription.entityForName("Item_Join", inManagedObjectContext: joinContext)
        joinData = Item_Join(entity: joinDescription!, insertIntoManagedObjectContext: joinContext)
        
        joinData.euid = "ev002"
        joinData.iuid = "vt004"
        
        do {
            try joinContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
}

public class testEvent {
    
    func initData() {
        rs_C_Event?._total?.count = "2"
        
        rs_C_Event?._category?.count![0] = "2"
        rs_C_Event?._category?.title![0] = "테스트1"
        rs_C_Event?._category?.idx![0] = "0"
        
        rs_C_Event?._category?.count![1] = "4"
        rs_C_Event?._category?.title![1] = "테스트2"
        rs_C_Event?._category?.idx![1] = "1"
        
        rs_C_Event?._item?.iuid![0] = "fr001"
        rs_C_Event?._item?.iuid![1] = "fr002"

        rs_C_Event?._item?.iuid![2] = "vt001"
        rs_C_Event?._item?.iuid![3] = "vt002"
        rs_C_Event?._item?.iuid![4] = "vt003"
        rs_C_Event?._item?.iuid![5] = "vt004"
    }
}