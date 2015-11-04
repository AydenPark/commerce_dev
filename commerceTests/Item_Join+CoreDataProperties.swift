//
//  Item_Join+CoreDataProperties.swift
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

extension Item_Join {

    @NSManaged var iuid: String?
    @NSManaged var euid: String?
    @NSManaged var tuid: String?

}
