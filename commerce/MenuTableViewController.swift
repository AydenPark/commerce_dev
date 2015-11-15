//
//  MenuTableViewController.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 15..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    @IBOutlet weak var navItem: UINavigationItem!

    var imageCell:UITableViewCell = UITableViewCell()
    var nameCell: UITableViewCell = UITableViewCell()
    var phoneCell: UITableViewCell = UITableViewCell()
    var addressCell: UITableViewCell = UITableViewCell()
    
    var imageView: UIImageView = UIImageView()
    
    var nameText: UILabel = UILabel()
    var phoneText: UILabel = UILabel()
    var addressText: UILabel = UILabel()
    
    var nameDetail: UIImageView = UIImageView()
    var phoneDetail: UIImageView = UIImageView()
    var addressDetail: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navItem.title = "사용자 설정"
        self.navItem.rightBarButtonItem? = UIBarButtonItem(image: UIImage(named: "btn_cancel"), style: .Bordered, target: self, action: "close")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func loadView() {
        super.loadView()
        
        let origImage = UIImage(named: "btn_detail");
        let tintedImage = origImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        self.nameCell.backgroundColor = UIColor.whiteColor()
        self.nameCell.frame.size.width = self.view.frame.width
        self.nameCell.textLabel?.text = "이   름"
        self.nameCell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 16.0)
        self.nameDetail.frame = CGRectMake(self.nameCell.frame.width - 34, self.nameCell.frame.height/2 - 13, 26, 26)
        self.nameDetail.image = tintedImage
        self.nameDetail.tintColor = UIColor.lightGrayColor()
        self.nameText.frame = CGRectMake(0, 0, self.nameCell.frame.width - 42, self.nameCell.frame.height)
        self.nameText.text = g_userInfo.getName()
        self.nameText.textAlignment = .Right
        self.nameText.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        self.nameCell.addSubview(self.nameDetail)
        self.nameCell.addSubview(self.nameText)
        
        self.phoneCell.backgroundColor = UIColor.whiteColor()
        self.phoneCell.frame.size.width = self.view.frame.width
        self.phoneCell.textLabel?.text = "연락처"
        self.phoneCell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 16.0)
        self.phoneDetail.frame = CGRectMake(self.phoneCell.frame.width - 34, self.phoneCell.frame.height/2 - 13, 26, 26)
        self.phoneDetail.image = tintedImage
        self.phoneDetail.tintColor = UIColor.lightGrayColor()
        self.phoneText.frame = CGRectMake(0, 0, self.phoneCell.frame.width - 42, self.phoneCell.frame.height)
        self.phoneText.text = g_userInfo.getPhone()
        self.phoneText.textAlignment = .Right
        self.phoneText.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        self.phoneCell.addSubview(self.phoneDetail)
        self.phoneCell.addSubview(self.phoneText)
        
        self.addressCell.backgroundColor = UIColor.whiteColor()
        self.addressCell.frame.size.width = self.view.frame.width
        self.addressDetail.frame = CGRectMake(self.addressCell.frame.width - 34, self.addressCell.frame.height/2 - 5, 26, 26)
        self.addressDetail.image = tintedImage
        self.addressDetail.tintColor = UIColor.lightGrayColor()
        self.addressText.frame = CGRectMake(16, 8, self.addressCell.frame.width - 58, self.addressCell.frame.height)
        self.addressText.text = g_userInfo.getAddress1() + "\n" + g_userInfo.getAddress2()
        self.addressText.textAlignment = .Left
        self.addressText.numberOfLines = 0
        self.addressCell.addSubview(self.addressDetail)
        self.addressCell.addSubview(self.addressText)
        
        self.imageCell.frame.size.width = self.view.frame.width
        self.imageView.image = UIImage(named: "img_test")
        self.imageView.frame = CGRectMake(self.imageCell.frame.width/2 - 72, 44, 144, 144)
        self.imageCell.addSubview(self.imageView)
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch(section) {
        case 0: return 1    // section 0 has 2 rows
        case 1: return 2    // section 1 has 1 row
        case 2: return 1
        default: fatalError("Unknown number of sections")
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            return self.imageCell
        case 1:
            switch(indexPath.row) {
            case 0: return self.nameCell   // section 0, row 0
            case 1: return self.phoneCell    // section 0, row 1
            default: fatalError("Unknown row in section 0")
            }
        case 2:
            return self.addressCell
        default: fatalError("Unknown section")
        }
    }

    func close() {
        self.dismissViewControllerAnimated(true, completion: nil);    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
