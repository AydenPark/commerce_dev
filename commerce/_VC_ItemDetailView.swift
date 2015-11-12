//
//  _VC_ItemDetailView.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 7..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController, UIGestureRecognizerDelegate, SubTagDispDelegate {

    @IBOutlet weak var navItem: UINavigationItem!
    var scrollView: UIScrollView!
    var itemSelectCount: Int = 1
    var countLabel: UILabel!
    var minusButton: UIButton!
    var plusButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navItem.title = "상세보기"
        self.navItem.leftBarButtonItem? = UIBarButtonItem(image: UIImage(named: "btn_back"), style: .Bordered, target: self, action: "goBack")

        self.scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.pagingEnabled = false
        self.scrollView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width, 0)
        
        self.view.addSubview(self.scrollView)
        initView()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.enabled = true
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        //상품 아이템
        let itemImageView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.width))
        itemImageView.backgroundColor = UIColor.whiteColor()
        self.scrollView.addSubview(itemImageView)
        
        var spaceView = UIView(frame: CGRectMake(0, itemImageView.frame.origin.y + itemImageView.frame.height, self.view.frame.width, 1))
        spaceView.backgroundColor = UIColor.lightGrayColor()
        self.scrollView.addSubview(spaceView)

        //상품 이름
        let itemNameView = UIView(frame: CGRectMake(0, spaceView.frame.origin.y + spaceView.frame.height, self.view.frame.width, 48))
        itemNameView.backgroundColor = UIColor.whiteColor()

        let itemNameLabel = UILabel(frame: CGRectMake(16, 0, itemNameView.frame.width - 32, itemNameView.frame.height))
        itemNameLabel.text = g_selectedItemInfo._name
        itemNameLabel.textColor = UIColorFromRGB(g_rs_Values.colorDarkGray)
        itemNameView.addSubview(itemNameLabel)
        self.scrollView.addSubview(itemNameView)
        
        //상품 가격 정보
        let itemPriceView = UIView(frame: CGRectMake(0, itemNameView.frame.origin.y + itemNameView.frame.height, self.view.frame.width, 56))
        itemPriceView.backgroundColor = UIColor.whiteColor()
        
        let discount = UILabel()
        let purchase = UILabel()
        let selling = UILabel()
        
        if((Float(g_selectedItemInfo._purchase!)) != nil) {
            let dc_value = (NSString(format:"%.f",100 - (Float(g_selectedItemInfo._selling!)! / Float(g_selectedItemInfo._purchase!)! * 100)) as String) + "%"
            let dc_attributedText = NSMutableAttributedString(string: dc_value, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: itemPriceView.frame.height - 8)!])
            dc_attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Medium", size: 18.0)!, range: NSRange(location:2,length:1))
            
            discount.frame = CGRectMake(16, 0, 0, itemPriceView.frame.height)
            discount.attributedText = dc_attributedText
            discount.textAlignment = .Left
            discount.textColor = UIColor.redColor()
            discount.sizeToFit()
            itemPriceView.addSubview(discount)
            
            let purchase_text = addComma(g_selectedItemInfo._purchase!) + "원"
            let purchase_attributedText = NSMutableAttributedString(string: purchase_text, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: itemPriceView.frame.height*0.25)!])
            purchase_attributedText.addAttribute(NSStrikethroughStyleAttributeName , value:1, range: NSRange(location: 0, length: purchase_text.length))
            
            purchase.frame = CGRectMake(discount.frame.origin.x + discount.frame.width + 16, discount.frame.minY + 8, (itemPriceView.frame.width-16) - (discount.frame.origin.x + discount.frame.width), itemPriceView.frame.height*0.25)
            purchase.attributedText = purchase_attributedText
            purchase.textColor = UIColor.grayColor()
            purchase.textAlignment = .Left
            purchase.sizeToFit()
            itemPriceView.addSubview(purchase)
            
            let selling_text = addComma(g_selectedItemInfo._selling!) + "원"
            let selling_attributedText = NSMutableAttributedString(string: selling_text, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Medium", size: itemPriceView.frame.height*0.5)!])
            selling_attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue", size: 14.0)!, range: NSRange(location:selling_text.length-1,length:1))
            selling.frame = CGRectMake(discount.frame.origin.x + discount.frame.width + 16, purchase.frame.maxY - 8, (itemPriceView.frame.width-16) - (discount.frame.origin.x + discount.frame.width), itemPriceView.frame.height*0.5)
            selling.attributedText = selling_attributedText
            selling.textColor = UIColor.blackColor()
            selling.textAlignment = .Left
            selling.sizeToFit()
            itemPriceView.addSubview(selling)
        } else {
            let selling_text = addComma(g_selectedItemInfo._selling!) + "원"
            let selling_attributedText = NSMutableAttributedString(string: selling_text, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Medium", size: itemPriceView.frame.height*0.75)!])
            selling_attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue", size: 18.0)!, range: NSRange(location:selling_text.length-1,length:1))
            selling.frame = CGRectMake(0, 0, itemPriceView.frame.width, itemPriceView.frame.height)
            selling.attributedText = selling_attributedText
            selling.textColor = UIColor.blackColor()
            selling.textAlignment = .Center
            itemPriceView.addSubview(selling)
        }
        
        self.scrollView.addSubview(itemPriceView)
        
        spaceView = UIView(frame: CGRectMake(0, itemPriceView.frame.origin.y + itemPriceView.frame.height, self.view.frame.width, 1))
        spaceView.backgroundColor = UIColor.lightGrayColor()
        self.scrollView.addSubview(spaceView)
        
        let itemDetailView = UIImageView(frame: CGRectMake(0, spaceView.frame.origin.y + spaceView.frame.height + 8, self.view.frame.width, 1000))
        itemDetailView.backgroundColor = UIColor.whiteColor()
//        itemDetailView.image = UIImage(named: "")
//        itemDetailView.sizeToFit()
        self.scrollView.addSubview(itemDetailView)
        
        spaceView = UIView(frame: CGRectMake(0, itemDetailView.frame.origin.y + itemDetailView.frame.height, self.view.frame.width, 56))
        spaceView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.scrollView.addSubview(spaceView)
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.width, spaceView.frame.origin.y + spaceView.frame.height)
        
        //구매하기 / 장바구니 버튼
        let buyMenuView = UIView(frame: CGRectMake(0, self.view.frame.height-56, self.view.frame.width, 56))
        buyMenuView.backgroundColor = UIColor.darkGrayColor()
        
        self.minusButton = UIButton(type: .System)
        self.minusButton.frame = CGRectMake(8, 8, buyMenuView.frame.height - 16, buyMenuView.frame.height - 16)
        self.minusButton.setImage(UIImage(named: "btn_minus"), forState: .Normal)
        self.minusButton.tintColor = UIColor.whiteColor()
        self.minusButton.tag = 2
        self.minusButton.addTarget(self, action: Selector("countButtonTapped:"), forControlEvents: .TouchUpInside)
        self.minusButton.enabled = false
        buyMenuView.addSubview(self.minusButton)
        
        self.countLabel = UILabel(frame: CGRectMake(self.minusButton.frame.origin.x + self.minusButton.frame.width + 8, 8, buyMenuView.frame.height - 30, buyMenuView.frame.height - 16))
        self.countLabel.text = String(self.itemSelectCount)
        self.countLabel.textAlignment = .Center
        self.countLabel.textColor = UIColor.whiteColor()
        self.countLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)!
        buyMenuView.addSubview(self.countLabel)
        self.countLabel.reloadInputViews()
        
        self.plusButton = UIButton(type: .System)
        self.plusButton.frame = CGRectMake(self.countLabel.frame.origin.x + self.countLabel.frame.width + 8, 8, buyMenuView.frame.height - 16, buyMenuView.frame.height - 16)
        self.plusButton.setImage(UIImage(named: "btn_plus"), forState: .Normal)
        self.plusButton.tintColor = UIColor.whiteColor()
        self.plusButton.tag = 1
        self.plusButton.addTarget(self, action: Selector("countButtonTapped:"), forControlEvents: .TouchUpInside)
        buyMenuView.addSubview(self.plusButton)

        let cartButton = UIButton(type: .System)
        cartButton.frame = CGRectMake(self.plusButton.frame.origin.x + self.plusButton.frame.width + 8, 8, (buyMenuView.frame.width - self.plusButton.frame.origin.x - self.plusButton.frame.width)/2 - 12, buyMenuView.frame.height - 16)
        cartButton.backgroundColor = UIColor.grayColor()
        cartButton.setTitle(g_rs_Strings._detail_cart_title, forState: .Normal)
        cartButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cartButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        cartButton.addTarget(self, action: Selector("cartButtonTapped:"), forControlEvents: .TouchUpInside)
        buyMenuView.addSubview(cartButton)
        
        let buyButton = UIButton(type: .System)
        buyButton.frame = CGRectMake(cartButton.frame.origin.x + cartButton.frame.width + 8, 8, (buyMenuView.frame.width - self.plusButton.frame.origin.x - self.plusButton.frame.width)/2 - 12, buyMenuView.frame.height - 16)
        buyButton.backgroundColor = UIColorFromRGB(g_rs_Values.colorDeepOrange)
        buyButton.setTitle(g_rs_Strings._detail_buy_title, forState: .Normal)
        buyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        buyButton.titleLabel!.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        buyButton.addTarget(self, action: Selector("buyButtonTapped:"), forControlEvents: .TouchUpInside)
        buyMenuView.addSubview(buyButton)
        
        self.view.addSubview(buyMenuView)
    }
    
    func cartButtonTapped(sender: UIButton!) {
        NSLog("cart button tapped")
        
        var inCartCount: Int = 0
        var exist: Bool = false
        //태그에 해당하는 아이템 필터
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = app.managedObjectContext
        let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Cart")
        request.returnsObjectsAsFaults = false
        
        var results: NSArray = []
        do {
            results = try context.executeFetchRequest(request)
            // success ...
            inCartCount = results.count
            
            for item in results {
                let iuid = item.valueForKey("iuid") as? String
                if iuid!.isEqual(g_selectedItemInfo._iuid) {
                    exist = true
                    let count = Int((item.valueForKey("count") as? String)!)!
                    item.setValue(String(count + self.itemSelectCount), forKey: "count")
                    g_pc_CHD.saveContext(context)
                }
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        if (!exist) {
            let cartDescription = NSEntityDescription.entityForName("Item_Cart", inManagedObjectContext: context)
            let cartData = Item_Cart(entity: cartDescription!, insertIntoManagedObjectContext: context)

            cartData.idx = String(inCartCount + 1)
            cartData.iuid = g_selectedItemInfo._iuid
            cartData.count = String(self.itemSelectCount)
            
            g_pc_CHD.saveContext(context)
        }
        
        self.view.makeToast(message: g_rs_Strings._cart_add_toast!, duration: 2, position: "center")
    }
    
    func countButtonTapped(sender: UIButton!) {
        NSLog("item count button tapped")
        if( sender.tag == 1 ) { self.itemSelectCount += 1 }
        else { self.itemSelectCount -= 1 }
        
        if( self.itemSelectCount < 2 ) { self.minusButton.enabled = false }
        else { self.minusButton.enabled = true }
        self.countLabel.text = String(self.itemSelectCount)
    }
    
    func buyButtonTapped(sender: UIButton!) {
        NSLog("buy button tapped")
        let title = g_rs_Strings._detail_buy_complete
        let message = g_rs_Strings._detail_bui_content
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.Default) {
            action in
            let buyItem = rsCBuys()
            buyItem._suid = g_userInfo.getSUID()
            buyItem._iuid = g_selectedItemInfo._iuid
            buyItem._name = g_selectedItemInfo._name
            buyItem._count = String(self.itemSelectCount)
            buyItem._price = g_selectedItemInfo._selling
            var buyItems = [rsCBuys]()
            buyItems.append(buyItem)
            SendToDB(buyItems)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        alert.addAction(okAction)
        
        self.presentViewController(alert, animated:true, completion:nil)
    }
    
    func tappedItemInfo(itemData: rsCItems) {
        g_selectedItemInfo = itemData
    }
    
    func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
