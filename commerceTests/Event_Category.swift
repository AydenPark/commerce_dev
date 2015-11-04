//
//  Event_Category.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 4..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import CoreData

@objc(Event_Category)
class Event_Category: NSManagedObject {
    func addSubObject(values: NSSet) {
        let items = self.mutableSetValueForKey("event_item")
        for value in values {
            items.addObject(value)
        }
    }
    
    func removeList(values: NSSet) {
        let items = self.mutableSetValueForKey("event_item")
        for value in values {
            items.removeObject(value)
        }
    }
// Insert code here to add functionality to your managed object subclass

}
