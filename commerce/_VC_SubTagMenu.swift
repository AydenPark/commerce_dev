//
//  _VC_DisplayView.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 6..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class SubTagMenu: UIView {
    var view = UIView()
    var button = [UIButton]()
    
    public func initView(value:[String], height:CGFloat, viewTag:Int) {
        self.view.frame = self.bounds
        
        var tabButton = UIButton(type: .System)
        tabButton.frame = CGRectMake(0, 0, self.view.frame.width / 3, height)
        tabButton.setTitle("전체", forState: .Normal)
        tabButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        tabButton.tag = viewTag+0
        self.button.append(tabButton)
        self.view.addSubview(tabButton)
        
        for n in 0...value.count-1 {
            var tabButton = UIButton(type: .System)
            tabButton.frame = CGRectMake((self.view.frame.width / 3) * CGFloat((n+1) % 3), height * CGFloat((n+1) / 3), self.view.frame.width / 3, height)
            tabButton.setTitle(MatchingNameViaTUID(value[n]), forState: .Normal)
            tabButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            tabButton.tag = viewTag+n+1
            self.button.append(tabButton)
            self.view.addSubview(tabButton)
        }
        self.addSubview(self.view)
    }
    
    private func MatchingNameViaTUID(tuid: String) -> String{
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let tagsContext:NSManagedObjectContext = app.managedObjectContext
        var tagsDescription = NSEntityDescription.entityForName("Item_Tag", inManagedObjectContext: tagsContext)
        var fReq: NSFetchRequest = NSFetchRequest(entityName: "Item_Tag")
        
        fReq.predicate = NSPredicate(format:"tuid == %@", tuid)
        let results = (try! tagsContext.executeFetchRequest(fReq)) as! [Item_Tag]

        return results[0].name!
    }        
}