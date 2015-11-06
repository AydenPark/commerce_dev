//
//  Item_Tag+CoreDataProperties.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 6..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item_Tag {

    @NSManaged var tuid: String?
    @NSManaged var name: String?
    @NSManaged var item_info: Item_Info?

}
