//
//  _VC_EventContent.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 5..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit

public class EventContentView: UIView {
    var view = UIView()
    
    var image = UIImageView()
    var name = UILabel()
    var discount = UILabel()
    var price = UILabel()
    public func initView(frame:CGSize, value:rsCItems) {
        self.view.frame = CGRectMake(0, 0, frame.width, frame.height)
        self.view.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.view)
        
        self.image.frame = CGRectMake(0, 0, frame.width, 3/4*frame.width)
        self.image.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.image)
        
        self.name.frame = CGRectMake(0, self.image.frame.height + 8, frame.width, 20)
        self.name.text = value._name
        self.name.textColor = UIColor.blackColor()
        self.name.textAlignment = .Center
        self.view.addSubview(self.name)
        
        self.discount.frame = CGRectMake(0, self.name.frame.origin.y + self.name.frame.height + 8, frame.width*0.4, self.view.frame.height - (self.name.frame.origin.y + self.name.frame.height + 8))
        self.discount.text = String(format:"%.f",100 - (Float(value._price!)! / Float(value._origin!)! * 100)) + "%"
        self.discount.textAlignment = .Center
        self.view.addSubview(self.discount)
        
        self.price.frame = CGRectMake(frame.width*0.4, self.name.frame.origin.y + self.name.frame.height + 8, frame.width*0.6, self.view.frame.height - (self.name.frame.origin.y + self.name.frame.height + 8))
        self.price.text = value._price! + "원"
        self.price.textColor = UIColor.blackColor()
        self.price.textAlignment = .Center
        self.view.addSubview(self.price)
    }
    
}