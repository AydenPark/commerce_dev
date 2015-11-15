//
//  AddressView.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 12..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit

class AddressView: UIView, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchTypeLabel: UILabel!
    @IBOutlet weak var searchTypeSub1: UILabel!
    @IBOutlet weak var searchTypeSub2: UILabel!
    @IBOutlet weak var searchTypeSub3: UILabel!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var searchResultView: UIView!
    
    var tableView: UITableView!
    var searchResults = NSMutableArray()
    var searchType: NSString = "postRoad"
    var strAddr1 = [NSString]()
    var strAddr2 = [NSString]()
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        initData()
        
        self.tableView = UITableView(frame: self.searchResultView.frame, style: UITableViewStyle.Plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.frame = CGRectMake(0, 0, self.searchResultView.frame.width, self.searchResultView.frame.height)
        self.tableView.separatorColor = UIColor.clearColor()
        
        self.searchResultView.addSubview(self.tableView)
    }
    
    func initData() {
        self.searchTypeLabel.text = g_rs_Strings._addr_type_title1
        self.searchTypeSub1.text = g_rs_Strings._addr_type_subtitle1_1
        self.searchTypeSub2.text = g_rs_Strings._addr_type_subtitle1_2
        self.searchTypeSub3.text = g_rs_Strings._addr_type_subtitle1_3
        self.searchResultLabel.text = g_rs_Strings._addr_type_result! + "0건"
        self.searchType = "postRoad"
    }

    @IBAction func closeButtonTapped(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("AddrViewDismiss", object: nil)
        self.removeFromSuperview()
    }

    @IBAction func searchType(sender: UISegmentedControl) {
        self.searchTF.text = ""
        switch sender.selectedSegmentIndex {
        case 0:
            self.searchTypeLabel.text = g_rs_Strings._addr_type_title1
            self.searchTypeSub1.text = g_rs_Strings._addr_type_subtitle1_1
            self.searchTypeSub2.text = g_rs_Strings._addr_type_subtitle1_2
            self.searchTypeSub3.text = g_rs_Strings._addr_type_subtitle1_3
            self.searchResultLabel.text = g_rs_Strings._addr_type_result! + "0건"
            self.searchResults = NSMutableArray()
            self.searchType = "postRoad"
            self.tableView.reloadData()
        case 1:
            self.searchTypeLabel.text = g_rs_Strings._addr_type_title2
            self.searchTypeSub1.text = g_rs_Strings._addr_type_subtitle2_1
            self.searchTypeSub2.text = g_rs_Strings._addr_type_subtitle2_2
            self.searchTypeSub3.text = ""
            self.searchResultLabel.text = g_rs_Strings._addr_type_result! + "0건"
            self.searchResults = NSMutableArray()
            self.searchType = "post"
            self.tableView.reloadData()
        default:
            return
        }
    }

    @IBAction func searchButtonTapped(sender: UIButton) {
        let strDong: NSString = self.searchTF.text!
        let strRegKey: NSString = "cc14f623705617f041447327250896"
        self.strAddr1 = [NSString]()
        self.strAddr2 = [NSString]()
        let postcode = PostCodeXMLParser()
    
        self.searchResults = postcode.getPostCode(self.searchType, strDong: strDong, strReg: strRegKey)
        
        if self.searchResults.count > 0 {
            self.searchResultLabel.text = (g_rs_Strings._addr_type_result! + String(self.searchResults.count) + "건")
            for n in 0...self.searchResults.count-1 {
                if (self.searchType == "postRoad") {
                    strAddr1.append(self.searchResults.objectAtIndex(n).objectForKey("addressRoad1") as! NSString)
                    strAddr2.append(self.searchResults.objectAtIndex(n).objectForKey("addressRoad2") as! NSString)
                } else {
                    strAddr1.append(self.searchResults.objectAtIndex(n).objectForKey("address") as! NSString)
                    strAddr2.append("")
                }
            }
            self.tableView.reloadData()
            self.endEditing(true)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return self.searchResults.count
    }
    
    func numberOfSectionsInTableView(tableView:UITableView)->Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "myIdentifier")
        let row = indexPath.row
        cell.selectionStyle = .Gray
        var tokenStringArr1 = self.strAddr1[row].componentsSeparatedByString(" ")
        var tokenStringArr2 = self.strAddr2[row].componentsSeparatedByString(" ")
        
        let resultLabel = UILabel()
        resultLabel.frame = CGRectMake(16, 0, cell.frame.width, cell.frame.height)
        
        if (self.searchType == "postRoad") {
            resultLabel.text = tokenStringArr1[0] + " " + tokenStringArr1[1] + " " + tokenStringArr1[2] + " " + tokenStringArr1[3] + "\r"
                            + tokenStringArr2[0] + " " + tokenStringArr2[1] + " " + tokenStringArr2[2] + " " + tokenStringArr2[3]
            resultLabel.numberOfLines = 0
        } else {
            resultLabel.text = tokenStringArr1[0] + " " + tokenStringArr1[1] + " " + tokenStringArr1[2] + " " + tokenStringArr1[3]
            resultLabel.numberOfLines = 1
        }
        resultLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        
        cell.addSubview(resultLabel)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        
        var delegate:AddressDelegate
        delegate = LogInViewController()
        delegate.selectedAddress(self.strAddr1[row] as String)
        
        NSNotificationCenter.defaultCenter().postNotificationName("AddrViewDismiss", object: nil)
        self.removeFromSuperview()
    }
}
