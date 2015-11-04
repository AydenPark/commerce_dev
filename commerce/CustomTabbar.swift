//
//  CustomTabbar.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 3..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit

public class CustomTabbar: UIView {
    var homeButton = UIButton()
    var tab1Button = UIButton()
    var tab2Button = UIButton()
    var tab3Button = UIButton()
    
    public func initView() {
        self.homeButton.frame = CGRectMake(0, 0, frame.width*0.25, frame.height)
        self.tab1Button.frame = CGRectMake(frame.width*0.25, 0, frame.width*0.25, frame.height)
        self.tab2Button.frame = CGRectMake(frame.width*0.25 * 2, 0, frame.width*0.25, frame.height)
        self.tab3Button.frame = CGRectMake(frame.width*0.25 * 3, 0, frame.width*0.25, frame.height)
        
        self.addSubview(self.homeButton)
        self.addSubview(self.tab1Button)
        self.addSubview(self.tab2Button)
        self.addSubview(self.tab3Button)
    }
    
}