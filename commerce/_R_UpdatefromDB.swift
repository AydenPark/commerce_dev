//
//  UpdatefromDB.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 4..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class Items_DB {
    func updateData() {
        test_Items?.initData()
        test_ItemsTag?.initData()
        test_ItemsEvent?.initData()
        test_ItemsJoin?.initData()
    }
}
