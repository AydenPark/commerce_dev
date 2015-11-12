//
//  Item_Cart+CoreDataProperties.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 9..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item_Cart {

    @NSManaged var idx: String?
    @NSManaged var iuid: String?
    @NSManaged var count: String?

}
