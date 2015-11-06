//
//  _VC_EventContent.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 5..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit

public class ItemContentView: UIView {
    var view = UIView()
    
    var image = UIImageView()
    var name = UILabel()
    var infoCanvas = UIView()
    var discount = UILabel()
    var purchase = UILabel()
    var selling = UILabel()
    var ItemInfo = rsCItems()
    
    public func initView(frame:CGSize, value:rsCItems) {
        self.ItemInfo = value
        self.view.frame = CGRectMake(0, 0, frame.width, frame.height - 8)
        self.view.backgroundColor = UIColor.whiteColor()
        self.addSubview(self.view)
        
        self.image.frame = CGRectMake(0, 0, frame.width, frame.width)
        self.image.backgroundColor = UIColor.grayColor()
        self.view.addSubview(self.image)
        
        self.name.frame = CGRectMake(0, self.image.frame.height, frame.width, (frame.height - self.image.frame.height) * CGFloat(0.55))
        self.name.text = value._name
        self.name.textColor = UIColor.blackColor()
        self.name.textAlignment = .Center
        self.view.addSubview(self.name)
        
        let canvasHeight = self.view.frame.height - (self.name.frame.origin.y + self.name.frame.height)
        self.infoCanvas.frame = CGRectMake(0, self.name.frame.origin.y + self.name.frame.height, frame.width, canvasHeight - 8)
        self.view.addSubview(self.infoCanvas)
        
        if((Float(value._purchase!)) != nil) {
            var dc_value = (NSString(format:"%.f",100 - (Float(value._selling!)! / Float(value._purchase!)! * 100)) as String) + "%"
            var dc_attributedText = NSMutableAttributedString(string: dc_value, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Medium", size: canvasHeight-8)!])
            dc_attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!, range: NSRange(location:2,length:1))
            dc_attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location: 0, length: 3))
            
            self.discount.frame = CGRectMake(8, 0, (self.infoCanvas.frame.width-16)*0.40, infoCanvas.frame.height)
            self.discount.attributedText = dc_attributedText
            self.discount.textAlignment = .Left
            self.infoCanvas.addSubview(self.discount)

            var purchase_text = addComma(value._purchase!) + "원"
            var purchase_attributedText = NSMutableAttributedString(string: purchase_text, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: canvasHeight*0.35)!])
            purchase_attributedText.addAttribute(NSStrikethroughStyleAttributeName , value:1, range: NSRange(location: 0, length: purchase_text.length))
            
            self.purchase.frame = CGRectMake(self.discount.frame.origin.x + self.discount.frame.width, 0, (self.infoCanvas.frame.width-16)*0.60 - 16, infoCanvas.frame.height*0.35)
            self.purchase.attributedText = purchase_attributedText
            self.purchase.textColor = UIColor.grayColor()
            self.purchase.textAlignment = .Left
            self.infoCanvas.addSubview(self.purchase)
            
            var selling_text = addComma(value._selling!) + " 원"
            var selling_attributedText = NSMutableAttributedString(string: selling_text, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: canvasHeight*0.5)!])
            selling_attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue", size: 14.0)!, range: NSRange(location:selling_text.length-1,length:1))
            self.selling.frame = CGRectMake(self.discount.frame.origin.x + self.discount.frame.width, self.purchase.frame.origin.y + self.purchase.frame.height + 4, (self.infoCanvas.frame.width-16)*0.60 - 16, infoCanvas.frame.height*0.5)
            self.selling.attributedText = selling_attributedText
            self.selling.textColor = UIColor.blackColor()
            self.selling.textAlignment = .Left
            self.infoCanvas.addSubview(self.selling)
        } else {
            var selling_text = addComma(value._selling!) + " 원"
            var selling_attributedText = NSMutableAttributedString(string: selling_text, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: canvasHeight*0.7)!])
            selling_attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue", size: 18.0)!, range: NSRange(location:selling_text.length-1,length:1))
            self.selling.frame = CGRectMake(0, 0, self.infoCanvas.frame.width, infoCanvas.frame.height)
            self.selling.attributedText = selling_attributedText
            self.selling.textColor = UIColor.blackColor()
            self.selling.textAlignment = .Center
            self.infoCanvas.addSubview(self.selling)
        }
        
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