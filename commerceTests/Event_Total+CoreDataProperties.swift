//
//  EventAbstract+CoreDataProperties.swift
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

extension Event_Total {

    @NSManaged var count: String?
    @NSManaged var event_category: NSSet?

}
