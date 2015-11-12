//
//  _R_CoreDataHelper.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 5..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper: NSObject{
    // save NSManagedObjectContext
    func saveContext (context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func deleteContext (entity: String, context: NSManagedObjectContext) {
        let deleteRequest = NSFetchRequest(entityName: entity)
        do {
            let deleteList = try context.executeFetchRequest(deleteRequest)
            // success ...
            for bas: AnyObject in deleteList {
                context.deleteObject(bas as! NSManagedObject)
            }
            do {
                try context.save()
            }
            catch {
                fatalError("Failure to save context: \(error)")
            }
            
        } catch let error as NSError { NSLog("Fetch failed: \(error.localizedDescription)") }
    }
}