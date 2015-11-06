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
    var tabButton = [UIButton()]
    var homeSelect = UIView()
    var tabSelect = [UIView()]
    var indicator = UIView()
    
    public func initView(frame:CGSize) {
        self.view.frame = CGRectMake(0, 0, frame.width, 45)
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.homeButton = UIButton(type: .System)
        self.homeButton.frame = CGRectMake(0, 0, frame.width*CGFloat(1.0/Double((rs_Strings?._tab_text.count)!+1)), 42)
        self.homeButton.setTitle(rs_Strings?._tab_home_text, forState: .Normal)
        self.homeButton.setTitleColor(UIColorFromRGB(colorDarkGray), forState: .Normal)
        self.homeButton.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 18)
        self.view.addSubview(self.homeButton)
        
        self.homeSelect.frame = CGRectMake(0, 40, frame.width*CGFloat(1.0/Double((rs_Strings?._tab_text.count)!+1)), 4)
        self.homeSelect.backgroundColor = UIColorFromRGB(colorNavigation)
        self.view.addSubview(self.homeSelect)
        
        if (rs_Strings?._tab_text.count)! > 0 {
            for n in 0...(rs_Strings?._tab_text.count)!-1 {
                var button = UIButton(type: .System)
                button.frame = CGRectMake(frame.width*CGFloat(1.0/Double((rs_Strings?._tab_text.count)!+1)) * CGFloat(n+1), 0, frame.width*CGFloat(1.0/Double((rs_Strings?._tab_text.count)!+1)), 42)
                button.setTitle((rs_Strings?._tab_text[n]!)!, forState: .Normal)
                button.setTitleColor(UIColorFromRGB(colorDarkGray), forState: .Normal)
                button.tag = 100 + n
                button.titleLabel!.font =  UIFont(name: "HelveticaNeue-Medium", size: 18)
                self.tabButton.append(button)
                self.view.addSubview(self.tabButton[n+1])
                var select = UIView()
                select.frame = CGRectMake(frame.width*CGFloat(1.0/Double((rs_Strings?._tab_text.count)!+1)) * CGFloat(n+1), 40, frame.width*CGFloat(1.0/Double((rs_Strings?._tab_text.count)!+1)), 4)
                select.tag = 200 + n
                select.backgroundColor = UIColorFromRGB(colorWhite)
                self.tabSelect.append(select)
                self.view.addSubview(self.tabSelect[n+1])
            }
        }
        
        self.indicator.frame = CGRectMake(0, 44, frame.width, 1)
        self.indicator.backgroundColor = UIColorFromRGB(colorGray)
        self.view.addSubview(self.indicator)
        
        self.addSubview(self.view)
    }
    
    public func selection(index: Int) {
        switch(index) {
        case 0:
            self.homeSelect.backgroundColor = UIColorFromRGB(colorDeepOrange)
            if (rs_Strings?._tab_text.count)! > 0 {
                for n in 1...(rs_Strings?._tab_text.count)! {
                    self.tabSelect[n].backgroundColor = UIColorFromRGB(colorWhite)
                }
            }
        default:
            self.homeSelect.backgroundColor = UIColorFromRGB(colorWhite)
            for n in 1...(rs_Strings?._tab_text.count)! {
                if n == index {
                    self.tabSelect[n].backgroundColor = UIColorFromRGB(colorDeepOrange)
                } else {
                    self.tabSelect[n].backgroundColor = UIColorFromRGB(colorWhite)
                }
                
            }
            
        }
    }
    
}