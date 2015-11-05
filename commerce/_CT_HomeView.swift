//
//  HomeView.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 4..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit

public class HomeView: UIView {
    var canvasView = UIScrollView()
    var contentView = [UIView()]
    var itemView = [UIView()]
    var eventCount: Int = 0
    
    public func initView(frame: CGSize) {
        self.canvasView.frame = CGRectMake(0, 0, frame.width, frame.height)
    }
    
    public func initContents(count: Int) {
   
//        var titleView = UILabel()
//        titleView.frame = CGRectMake(0, 0, self.canvasView.frame.width, CGFloat((rs_Values?._text_area_height)!))
//        for n in 0...count {
//            var x_pos = 8 + Int(frame.width/2) * Int(n%2)
//            var y_pos = 8 + Int(frame.width/2) * Int(n/2)
//
//            self.contentView[n].frame = CGRectMake(CGFloat(x_pos), CGFloat(y_pos), frame.width/2-16, frame.width/2-16)
//            
//        }
    }
    
    public func initParts(count: Int) {
        
    }
}
