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
    var infoCanvas = UIView()
    var discount = UILabel()
    var origin_price = UILabel()
    var price = UILabel()
    
    public func initView(frame:CGSize, value:rsCItems) {
        print(frame)
        self.view.frame = CGRectMake(0, 0, frame.width, frame.height)
        self.view.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.view)
        
        self.image.frame = CGRectMake(0, 0, frame.width, 3/4*frame.width)
        self.image.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.image)
        
        self.name.frame = CGRectMake(0, self.image.frame.height + 8, frame.width, 32)
        self.name.text = value._name
        self.name.textColor = UIColor.blackColor()
        self.name.textAlignment = .Center
        self.view.addSubview(self.name)
        
        let canvasHeight = self.view.frame.height - (self.name.frame.origin.y + self.name.frame.height + 16) - 8
        self.infoCanvas.frame = CGRectMake(0, self.name.frame.origin.y + self.name.frame.height + 16, frame.width, canvasHeight)
        self.view.addSubview(self.infoCanvas)
        
        var dc_value = (NSString(format:"%.f",100 - (Float(value._price!)! / Float(value._origin!)! * 100)) as String) + "%"
        var dc_attributedText = NSMutableAttributedString(string: dc_value, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: canvasHeight)!])
        dc_attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!, range: NSRange(location:2,length:1))
        dc_attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location: 0, length: 3))
        
        self.discount.frame = CGRectMake(8, 0, (self.infoCanvas.frame.width-16)*0.45, canvasHeight)
        self.discount.attributedText = dc_attributedText
        self.discount.textAlignment = .Left
        self.infoCanvas.addSubview(self.discount)

        var origin_price_text = addComma(value._origin!) + "원"
        var origin_price_attributedText = NSMutableAttributedString(string: origin_price_text, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: canvasHeight*0.35)!])
        origin_price_attributedText.addAttribute(NSStrikethroughStyleAttributeName , value:1, range: NSRange(location: 0, length: origin_price_text.length))
        
        self.origin_price.frame = CGRectMake((self.infoCanvas.frame.width-16)*0.45 + 16, 4, (self.infoCanvas.frame.width-16)*0.55 - 16, canvasHeight*0.35)
        self.origin_price.attributedText = origin_price_attributedText
        self.origin_price.textColor = UIColor.grayColor()
        self.origin_price.textAlignment = .Left
        self.infoCanvas.addSubview(self.origin_price)
        
        var price_text = addComma(value._price!) + " 원"
        var price_attributedText = NSMutableAttributedString(string: price_text, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: canvasHeight*0.5)!])
        price_attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue", size: 14.0)!, range: NSRange(location:price_text.length-1,length:1))
        self.price.frame = CGRectMake((self.infoCanvas.frame.width-16)*0.45 + 16, self.origin_price.frame.origin.y + self.origin_price.frame.height, (self.infoCanvas.frame.width-16)*0.55 - 16, canvasHeight*0.5)
        self.price.attributedText = price_attributedText
        self.price.textColor = UIColor.blackColor()
        self.price.textAlignment = .Left
        self.infoCanvas.addSubview(self.price)
        
        self.view.addSubview(self.infoCanvas)
    }
    
    func addComma(str:String) -> String{
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.currencySymbol = ""
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        if(str != "") {
            return formatter.stringFromNumber(Double(str)!)!
        }else{
            return ""
        }
    }
    
}