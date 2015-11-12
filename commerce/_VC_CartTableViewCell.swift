//
//  _VC_CartTableViewCell.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 9..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var itemCheckButton: UIButton!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemCountLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var itemChecked: Bool! = true
    var itemPrice: Int = 0
    var itemCount: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.itemCountLabel.text = String(self.itemCount)
        
        changeCheckIcon(self.itemChecked)
        self.backgroundColor = UIColor.clearColor()
        
        self.plusButton.tag = 1
        self.minusButton.tag = 2
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func changeCheckIcon(check: Bool) {
        if check { self.itemCheckButton.setImage(UIImage(named: "btn_check"), forState: .Normal) }
        else { self.itemCheckButton.setImage(UIImage(named: "btn_uncheck"), forState: .Normal) }
    }
//    
//    @IBAction func itemCheckTapped(sender: AnyObject) {
//        self.itemChecked = !self.itemChecked
//        changeCheckIcon(self.itemChecked)
//    }
    
    func addComma(str:String) -> String{
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        formatter.currencySymbol = ""
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        if(str != "") {
            return formatter.stringFromNumber(Int(str)!)!
        }else{
            return ""
        }
    }
 }
