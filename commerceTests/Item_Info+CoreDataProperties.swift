//
//  Item_Info+CoreDataProperties.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 5..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item_Info {

    @NSManaged var image: String?
    @NSManaged var iuid: String?
    @NSManaged var name: String?
    @NSManaged var purchase: String?
    @NSManaged var selling: String?
    @NSManaged var item_event: NSSet?
    @NSManaged var item_tag: NSSet?

    func addEvent(values: Item_Event) {
        var items = self.mutableSetValueForKey("item_event");
        items.addObject(values)
    }
    
    func addTag(values: Item_Tag) {
        var items = self.mutableSetValueForKey("item_tag");
        items.addObject(values)
    }
}
