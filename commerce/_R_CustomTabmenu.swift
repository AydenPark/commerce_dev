//
//  CustomTabmenu.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 3..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit

public class CustomTabmenu: UIView {
    var view = UIView()
    
    var homeButton = UIButton()
    var tab1Button = UIButton()
    var tab2Button = UIButton()
    var tab3Button = UIButton()
    
    var homeSelect = UIView()
    var tab1Select = UIView()
    var tab2Select = UIView()
    var tab3Select = UIView()
    
    public func initView(frame:CGSize) {
        self.view.frame = CGRectMake(0, 0, frame.width, 44)
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.homeButton = UIButton(type: .System)
        self.homeButton.frame = CGRectMake(0, 0, frame.width*0.25, 42)
        self.homeButton.setTitle(rs_Strings?._tab_home_text, forState: .Normal)
        self.homeButton.setTitleColor(UIColorFromRGB(colorDarkGray), forState: .Normal)
        self.homeButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 18)
        
        self.tab1Button = UIButton(type: .System)
        self.tab1Button.frame = CGRectMake(frame.width*0.25, 0, frame.width*0.25, 42)
        self.tab1Button.setTitle(rs_Strings?._tab_tab1_text, forState: .Normal)
        self.tab1Button.setTitleColor(UIColorFromRGB(colorDarkGray), forState: .Normal)
        self.tab1Button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 18)
        
        self.tab2Button = UIButton(type: .System)
        self.tab2Button.frame = CGRectMake(frame.width*0.25 * 2, 0, frame.width*0.25, 42)
        self.tab2Button.setTitle(rs_Strings?._tab_tab2_text, forState: .Normal)
        self.tab2Button.setTitleColor(UIColorFromRGB(colorDarkGray), forState: .Normal)
        self.tab2Button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 18)
        
        self.tab3Button = UIButton(type: .System)
        self.tab3Button.frame = CGRectMake(frame.width*0.25 * 3, 0, frame.width*0.25, 42)
        self.tab3Button.setTitle(rs_Strings?._tab_tab3_text, forState: .Normal)
        self.tab3Button.setTitleColor(UIColorFromRGB(colorDarkGray), forState: .Normal)
        self.tab3Button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 18)
        
        self.view.addSubview(self.homeButton)
        self.view.addSubview(self.tab1Button)
        self.view.addSubview(self.tab2Button)
        self.view.addSubview(self.tab3Button)
        
        self.homeSelect.frame = CGRectMake(0, 40, frame.width*0.25, 4)
        self.tab1Select.frame = CGRectMake(frame.width*0.25, 40, frame.width*0.25, 4)
        self.tab2Select.frame = CGRectMake(frame.width*0.25 * 2, 40, frame.width*0.25, 4)
        self.tab3Select.frame = CGRectMake(frame.width*0.25 * 3, 40, frame.width*0.25, 4)
        
        self.homeSelect.backgroundColor = UIColorFromRGB(colorNavigation)
        self.tab1Select.backgroundColor = UIColorFromRGB(colorNavigation)
        self.tab2Select.backgroundColor = UIColorFromRGB(colorNavigation)
        self.tab3Select.backgroundColor = UIColorFromRGB(colorNavigation)
        
        self.view.addSubview(self.homeSelect)
        self.view.addSubview(self.tab1Select)
        self.view.addSubview(self.tab2Select)
        self.view.addSubview(self.tab3Select)
        
        self.addSubview(self.view)
    }
    
    public func selection(index: Int) {
        switch(index) {
        case 0:
            self.homeSelect.backgroundColor = UIColorFromRGB(colorNavigation)
            self.tab1Select.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab2Select.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab3Select.backgroundColor = UIColorFromRGB(colorWhite)
        case 1:
            self.homeSelect.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab1Select.backgroundColor = UIColorFromRGB(colorNavigation)
            self.tab2Select.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab3Select.backgroundColor = UIColorFromRGB(colorWhite)
        case 2:
            self.homeSelect.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab1Select.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab2Select.backgroundColor = UIColorFromRGB(colorNavigation)
            self.tab3Select.backgroundColor = UIColorFromRGB(colorWhite)
        case 3:
            self.homeSelect.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab1Select.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab2Select.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab3Select.backgroundColor = UIColorFromRGB(colorNavigation)
        default:
            self.homeSelect.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab1Select.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab2Select.backgroundColor = UIColorFromRGB(colorWhite)
            self.tab3Select.backgroundColor = UIColorFromRGB(colorWhite)
        }
    }
    
}