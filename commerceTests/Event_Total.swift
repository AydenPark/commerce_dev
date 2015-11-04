//
//  Event_Total.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 4..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import CoreData

@objc(Event_Total)
class Event_Total: NSManagedObject {
    func addSubObject(value: Event_Category) {
        let items = self.mutableSetValueForKey("event_category")
        items.addObject(value)
    }
    
    func removeList(value: Event_Category) {
        let items = self.mutableSetValueForKey("event_category")
        items.removeObject(value)
    }
// Insert code here to add functionality to your managed object subclass

}
