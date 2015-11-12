//
//  _VC_SubTagDispView.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 6..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import Foundation
import UIKit
import CoreData

public class SubTagDisp: UIView {
    var view = UIView()
    var itemView = [ItemContentView()]
    
    public func initView(value:[rsCItems], count:Int) {
        self.view.frame = self.bounds
        
        let width = frame.width/2 - 12
        let height = (self.bounds.height) / CGFloat((count / 2) + (count % 2))
        
        for n in 0...count-1 {
            let contentView = ItemContentView()
            contentView.frame = CGRectMake((8 - 4 * (CGFloat(n)%2)) + (CGFloat(frame.width)/2 * (CGFloat(n)%2)), (height * CGFloat(Int(n/2))), width, height)
            contentView.initView(contentView.frame.size, value: value[n])
            contentView.tag = n+1
            let gesture = UITapGestureRecognizer(target: self, action: Selector("Tapped:"))
            self.itemView.append(contentView)
            self.view.addSubview(contentView)
            contentView.addGestureRecognizer(gesture)
        }
        self.addSubview(self.view)
    }
    
    func Tapped(sender:UITapGestureRecognizer) {
        NSLog("tapped subItem' iuid : %@", self.itemView[(sender.view?.tag)!].ItemInfo._iuid!)
        NSLog("tapped subItem' name : %@", self.itemView[(sender.view?.tag)!].ItemInfo._name!)
   
        var delegate:SubTagDispDelegate
        delegate = ItemDetailViewController()
        delegate.tappedItemInfo(self.itemView[(sender.view?.tag)!].ItemInfo)
        
        let rootViewController = self.window!.rootViewController as! UINavigationController
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = mainStoryboard.instantiateViewControllerWithIdentifier("detailView") as UIViewController
        rootViewController.pushViewController(detailViewController, animated: true)
    }
}