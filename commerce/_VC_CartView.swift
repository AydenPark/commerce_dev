//
//  CartViewController.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 9..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var itemCheckButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var allItemCheck: Bool! = true
    var totalPrices: Int = 0
    var itemChecks = [Bool]()
    var itemIUIDs = [String]()
    var itemNames = [String]()
    var itemImages = [String]()
    var itemPrices = [String]()
    var itemCounts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navItem.title = "장바구니"
        self.navItem.rightBarButtonItem? = UIBarButtonItem(image: UIImage(named: "btn_cancel"), style: .Bordered, target: self, action: "close")
        
        self.tableView.separatorColor = UIColor.clearColor()
        self.initData { (success) -> Void in
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
        
        changeCheckIcon(self.allItemCheck)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    @IBAction func allItemCheck(sender: AnyObject) {
        self.allItemCheck = !self.allItemCheck
        changeCheckIcon(self.allItemCheck)

        if self.itemNames.count > 0 {
            for n in 0...self.itemNames.count-1 {
                let indexPath = NSIndexPath(forRow: n, inSection: 0)
                let cell = tableView.cellForRowAtIndexPath(indexPath) as! CartTableViewCell
                    self.itemChecks[n] = self.allItemCheck
                    cell.itemChecked = self.itemChecks[n]
                    cell.changeCheckIcon(cell.itemChecked)
            }
        }
    }
    
    @IBAction func ItemDelete(sender: AnyObject) {
    }
    
    func initData(completion:(success:Bool) -> Void) {
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = app.managedObjectContext
        let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Cart")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = []
        do {
            results = try context.executeFetchRequest(request)
            // success ...
            for item in results {
                self.itemChecks.append(true)
                self.itemIUIDs.append(item.valueForKey("iuid") as! String)
                self.itemCounts.append(item.valueForKey("count") as! String)
                
                let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let itemsContext:NSManagedObjectContext = app.managedObjectContext
                let fReq: NSFetchRequest = NSFetchRequest(entityName: "Item_Info")
                fReq.predicate = NSPredicate(format:"iuid == %@", item.valueForKey("iuid") as! String)
                for result in (try! itemsContext.executeFetchRequest(fReq)) as! [Item_Info] {
                    self.itemNames.append(result.name!)
                    self.itemImages.append(result.image!)
                    self.itemPrices.append(result.selling!)
                }
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        calcTotalPrice()
        completion(success:true)
    }
    
    func calcTotalPrice() {
        self.totalPrices = 0
        if self.itemNames.count > 0 {
            for n in 0...self.itemNames.count-1 {
                let price = Int(self.itemCounts[n])! * Int(self.itemPrices[n])!
                self.totalPrices += price
            }
        }
        self.totalPriceLabel.text = addComma(String(totalPrices))
    }
    
    func changeCheckIcon(check: Bool) {
        if check { self.itemCheckButton.setImage(UIImage(named: "btn_check"), forState: .Normal) }
        else { self.itemCheckButton.setImage(UIImage(named: "btn_uncheck"), forState: .Normal) }
    }
    
    @IBAction func skipButtonTapped(sender: AnyObject) {
        close()
    }
    
    @IBAction func buyButtonTapped(sender: AnyObject) {
        NSLog("buy button tapped")
        let title = g_rs_Strings._detail_buy_complete
        let message = g_rs_Strings._detail_bui_content
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default) {
            action in
            var buyItems = [rsCBuys]()
            for n in 0...self.itemChecks.count-1 {
                if self.itemChecks[n] {
                    let buyItem = rsCBuys()
                    buyItem._suid = g_userInfo.getSUID()
                    buyItem._iuid = self.itemIUIDs[n]
                    buyItem._name = self.itemNames[n]
                    buyItem._count = self.itemCounts[n]
                    buyItem._price = self.itemPrices[n]
                    buyItems.append(buyItem)
                }
            }
            SendToDB(buyItems)
            
            //장바구니 비우기
            let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let cartContext:NSManagedObjectContext = app.managedObjectContext
            g_pc_CHD.deleteContext("Item_Cart", context: cartContext)
                        
            self.navigationController?.popViewControllerAnimated(true)
            self.close()
        }
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated:true, completion:nil)
    }
 
    func close() {
        self.dismissViewControllerAnimated(false, completion: nil);    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return self.itemIUIDs.count
    }
    
    func numberOfSectionsInTableView(tableView:UITableView)->Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CartTableViewCell", forIndexPath: indexPath) as! CartTableViewCell
        
        let row = indexPath.row

        cell.itemChecked = self.itemChecks[row]
        cell.itemImageView.image = UIImage(named: self.itemImages[row])
        cell.itemNameLabel.text = self.itemNames[row]
        cell.itemPrice = Int(self.itemPrices[row])!
        let price = Int(self.itemPrices[row])! * Int(self.itemCounts[row])!
        cell.itemPriceLabel.text = addComma(String(price))
        cell.itemCount = Int(self.itemCounts[row])!
        cell.itemCountLabel.text = self.itemCounts[row]
    
        return cell
    }
    
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
    
    //button action in tablecell
    @IBAction func cellButtonTapped(sender: AnyObject) {
        let point = sender.convertPoint(CGPointZero, toView: tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(point)!
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CartTableViewCell
        
        NSLog("item count button tapped")
        if( sender.tag == 1 ) { cell.itemCount += 1 }
        else { cell.itemCount -= 1 }
        
        if( cell.itemCount < 2 ) { cell.minusButton.enabled = false }
        else { cell.minusButton.enabled = true }
        
        cell.itemCountLabel.text = String(cell.itemCount)
        cell.itemPriceLabel.text = addComma(String(cell.itemPrice * cell.itemCount))
        
        let row = indexPath.row
        self.itemCounts[row] = String(cell.itemCount)
        
        calcTotalPrice()
        
        //태그에 해당하는 아이템 필터
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = app.managedObjectContext
        let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Cart")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = []
        do {
            results = try context.executeFetchRequest(request)
            // success ...
            
            for item in results {
                let iuid = item.valueForKey("iuid") as? String
                if iuid!.isEqual(self.itemIUIDs[row]) {
                    item.setValue(self.itemCounts[row], forKey: "count")
                    g_pc_CHD.saveContext(context)
                }
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }

    @IBAction func cellCheckButtonTapped(sender: AnyObject) {
        let point = sender.convertPoint(CGPointZero, toView: tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(point)!
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CartTableViewCell
        let row = indexPath.row
        
        self.itemChecks[row] = !(self.itemChecks[row])
        
        cell.itemChecked = self.itemChecks[row]
        cell.changeCheckIcon(cell.itemChecked)
        
        var checkstate = true
        for check in self.itemChecks {
            print(check)
            if check == false {
                checkstate = false
            }
        }
        
        if(checkstate == false) {
            self.allItemCheck = false
            self.changeCheckIcon(self.allItemCheck)
        } else {
            self.allItemCheck = true
            self.changeCheckIcon(self.allItemCheck)
        }
        
    }
    
    @IBAction func cellDetailButtonTapped(sender: AnyObject) {
        let point = sender.convertPoint(CGPointZero, toView: tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(point)!
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CartTableViewCell
        let row = indexPath.row
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
