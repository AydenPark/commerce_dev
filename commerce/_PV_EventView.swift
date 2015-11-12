//
//  _VC_EventView.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 5..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit

public class EventView: UIView {
    var view = UIView()
    
    var titleLabel = UILabel()
    var itemView = [ItemContentView()]
    
    public func initView(title:String, value:[rsCItems], count:Int) {
        self.view.frame = self.bounds

        self.titleLabel.frame = CGRectMake(0, 0, frame.width, 48)
        self.titleLabel.text = title
        self.titleLabel.textAlignment = .Center
        self.view.addSubview(self.titleLabel)
        let width = frame.width/2 - 12
        let height = (self.bounds.height - 64 - 8) / CGFloat((count / 2) + (count % 2))

        for n in 0...count-1 {
            let contentView = ItemContentView()
            contentView.frame = CGRectMake((8 - 4 * (CGFloat(n)%2)) + (CGFloat(frame.width)/2 * (CGFloat(n)%2)), 64 + 8 + (height * CGFloat(Int(n/2))), width, height)
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
        NSLog("tapped Item' iuid : %@", self.itemView[(sender.view?.tag)!].ItemInfo._iuid!)
        NSLog("tapped Item' name : %@", self.itemView[(sender.view?.tag)!].ItemInfo._name!)
        
        var delegate:SubTagDispDelegate
        delegate = ItemDetailViewController()
        delegate.tappedItemInfo(self.itemView[(sender.view?.tag)!].ItemInfo)
        
        let rootViewController = self.window!.rootViewController as! UINavigationController
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = mainStoryboard.instantiateViewControllerWithIdentifier("detailView") as UIViewController
        rootViewController.pushViewController(detailViewController, animated: true)
    }
}
