//
//  Item_Info+CoreDataProperties.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 4..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item_Info {

    @NSManaged var iuid: String?
    @NSManaged var name: String?
    @NSManaged var origin: String?
    @NSManaged var price: String?
    @NSManaged var image: String?
    @NSManaged var item_event: NSSet?
    @NSManaged var item_tag: NSSet?

}
