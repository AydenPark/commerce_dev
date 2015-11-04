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
    var itemView = [EventContentView()]
    
    public func initView(title:String, value:[rsCItems], count:Int) {
        self.view.frame = self.bounds
    
        self.titleLabel.frame = CGRectMake(0, 8, frame.width, 48)
        self.titleLabel.text = title
        self.titleLabel.textAlignment = .Center
        self.view.addSubview(titleLabel)
        
        for n in 0...count-1 {
            let tmpView = EventContentView()
            let width = frame.width/2 - 12
            let height = (self.bounds.height - 48 - 16) / CGFloat(Int(count/2))
            tmpView.frame = CGRectMake((8 - 4 * (CGFloat(n)%2)) + (CGFloat(frame.width)/2 * (CGFloat(n)%2)), 48 + (height * CGFloat(Int(n/2)) + (8 * CGFloat(Int(n/2)))), width, height)
            var contentView = EventContentView()
            contentView.initView(tmpView.frame.size, value: value[n])
            tmpView.addSubview(contentView)
            self.itemView.append(tmpView)
            self.view.addSubview(tmpView)
        }
        self.addSubview(self.view)
    }
}
