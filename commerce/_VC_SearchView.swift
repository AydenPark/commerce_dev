//
//  SearchViewController.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 12..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var navItem: UINavigationItem!
    
    var targetName: String!
    var resultItems = [rsCItems]()
    var resultCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navItem.title = "검색결과"
        self.navItem.leftBarButtonItem? = UIBarButtonItem(image: UIImage(named: "btn_back"), style: .Bordered, target: self, action: "goBack")
        // Do any additional setup after loading the view.
        initData()
        
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() {
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //이름이 일치하는 상품 검색
        let itemContext:NSManagedObjectContext = app.managedObjectContext
        let iReq: NSFetchRequest = NSFetchRequest(entityName: "Item_Info")
        iReq.predicate = NSPredicate(format:"name CONTAINS %@", self.targetName as String)
        let iResults = (try! itemContext.executeFetchRequest(iReq)) as! [Item_Info]
        self.resultCount = iResults.count
        
        //검색에 해당하는 아이템 필터
        for item in iResults {
            let tmpItem = rsCItems()
            tmpItem._iuid = item.valueForKey("iuid") as? String
            tmpItem._name = item.valueForKey("name") as? String
            tmpItem._image = item.valueForKey("image") as? String
            tmpItem._selling = item.valueForKey("selling") as? String
            tmpItem._purchase = item.valueForKey("purchase") as? String
            tmpItem._tag = (MatchingTagViaIUID(tmpItem._iuid!)).sort()
            self.resultItems.append(tmpItem)
        }
        //태그가 일치하는 상품 검색
        let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Info")
        request.returnsObjectsAsFaults = false

        var results: NSArray = []

        do {
            results = try itemContext.executeFetchRequest(request)
            // success ...
            print(results.count)
            for item in results {
                let tmp = item as! Item_Info
                for tag in tmp.item_tag! {
                    let tagName: String = (tag.valueForKey("name") as? String)!
                    if tagName.containsString(self.targetName) {
                        let tmpItem = rsCItems()
                        tmpItem._iuid = item.valueForKey("iuid") as? String
                        tmpItem._name = item.valueForKey("name") as? String
                        tmpItem._image = item.valueForKey("image") as? String
                        tmpItem._selling = item.valueForKey("selling") as? String
                        tmpItem._purchase = item.valueForKey("purchase") as? String
                        tmpItem._tag = (MatchingTagViaIUID(tmpItem._iuid!)).sort()
                        self.resultCount += 1
                        self.resultItems.append(tmpItem)
                    }
                }
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        self.resultItems = resultItems.sort { (element1, element2) -> Bool in
            return element1._iuid < element2._iuid
        }
    }
    
    func initView() {
        if resultCount == 0 {
            let noneLabel = UILabel()
            noneLabel.frame = CGRectMake(0, self.view.frame.height/2, self.view.frame.width, 20)
            noneLabel.text = g_rs_Strings._search_none_item
            noneLabel.textAlignment = .Center
            self.view.addSubview(noneLabel)
        } else {
            //ScrollView 생성=
            let canvasScrollView = UIScrollView()
            canvasScrollView.frame =  CGRectMake(0, 8, self.view.frame.width , self.view.frame.height)
            canvasScrollView.scrollEnabled = true
 
            let content_height = 3/2 * self.view.frame.width/2
        
            let viewHeight = (content_height * CGFloat((self.resultItems.count / 2) + (self.resultItems.count % 2))) + (8 * CGFloat((self.resultItems.count / 2) + (self.resultItems.count % 2)))
            
            let resultDispView = SubTagDisp()
            resultDispView.frame = CGRectMake(0, 0, self.view.frame.width, viewHeight)
            resultDispView.initView(self.resultItems, count: self.resultItems.count)
            canvasScrollView.addSubview(resultDispView)
            
            canvasScrollView.contentSize = CGSizeMake(self.view.frame.width, resultDispView.frame.origin.y + resultDispView.frame.height)
            self.view.addSubview(canvasScrollView)
        }
    }
    
    func goBack() {
        self.navigationController?.popViewControllerAnimated(true)
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
