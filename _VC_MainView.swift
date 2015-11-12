//
//  Main_ViewController.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 3..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UIScrollViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var navItem: UINavigationItem!
    
    private var customTabmenu = CustomTabmenu()
    private var scrollView: UIScrollView!

    let searchBar:UISearchBar = UISearchBar()
    var scrollPages = [UILabel]()
    override func viewDidLoad() {
        
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if firstLaunch {
            g_userInfo.getUserPrefs()
            let navWidth = self.navigationController?.navigationBar.frame.width
            let customView:UIView = UIView(frame: CGRectMake(0, 0, navWidth!, 44))
            
            //margin 16px, icon 36, margin 16px => 68 x 2 = 136
            let titleLabel:UILabel = UILabel(frame: CGRectMake(0, 0, (customView.frame.width - 136) * 0.4 - 8, 44))
            titleLabel.text = g_rs_Strings._main_navi_title
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            
            //modify searchBar
            //create searchBar
            self.searchBar.delegate = self
            self.searchBar.searchBarStyle = UISearchBarStyle.Minimal
            self.searchBar.placeholder = g_rs_Strings._main_searchbar_ph
            let textFieldInsideSearchBar = self.searchBar.valueForKey("searchField") as? UITextField //change text color
            textFieldInsideSearchBar?.textColor = UIColor.whiteColor()
            let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.valueForKey("placeholderLabel") as? UILabel //change placeholder color
            textFieldInsideSearchBarLabel?.textColor = UIColor.whiteColor()
            let image: UIImage = UIImage(named: "ic_search")! //change search icon
            self.searchBar.setImage(image, forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
            //view for searchBar
            let searchBarView:UIView = UIView(frame: CGRectMake((customView.frame.width - 136) * 0.4 + 8, 0, (customView.frame.width - 136) * 0.6 - 8, 44))
            searchBarView.addSubview(self.searchBar)
            self.searchBar.sizeToFit()
            
            customView.addSubview(titleLabel)
            customView.addSubview(searchBarView)
            self.navigationItem.titleView = customView
            
            //update datas from DB
            g_pc_UpdateDB.updateEventsData()
            g_pc_UpdateDB.updateTagsData()
            g_pc_UpdateDB.updateItemsData()
            
            //custom tabbar
            self.customTabmenu.frame = CGRectMake(0, customView.frame.height + 20, self.view.frame.width, 45)
            self.customTabmenu.initView(self.view.frame.size)
            self.view.addSubview(self.customTabmenu)
            
            //init custom tabbar button event
            self.customTabmenu.homeButton.addTarget(self, action: Selector("homeButtonTapped:"), forControlEvents: .TouchUpInside)
            for n in 0...self.customTabmenu.tabButton.count-1 {
                self.customTabmenu.tabButton[n].addTarget(self, action: Selector("tabButtonTapped:"), forControlEvents: .TouchUpInside)
            }
            
            //scrollview -> content view
            self.scrollView = UIScrollView(frame: CGRectMake(0, customView.frame.height + 20 + self.customTabmenu.frame.height, self.view.frame.width, self.view.frame.height - (customView.frame.height + 20 + self.customTabmenu.frame.height)))
            self.scrollView.backgroundColor = UIColor.clearColor()
            self.scrollView.showsHorizontalScrollIndicator = false;
            self.scrollView.showsVerticalScrollIndicator = false
            self.scrollView.pagingEnabled = true
            self.scrollView.delegate = self
            self.view.addSubview(self.scrollView)
            
            
            initView()
            
            let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self,action: "dismissKeyboard")
            self.view.addGestureRecognizer(tap)
        } else {
            g_userInfo.initData()
            self.performSegueWithIdentifier("LoginView", sender: self)
        }
        
        super.viewDidLoad()
    }
    
    func dismissKeyboard() {
        self.searchBar.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SearchResult" {
            if let VC = segue.destinationViewController as? SearchViewController {
               VC.targetName = self.searchBar.text
            }
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.performSegueWithIdentifier("SearchResult", sender: self)
        self.searchBar.text = ""
    }
    
    func initView() {
        //pageSize => 메뉴 탭 갯수
        let pageSize = (g_rs_Strings._tab_text.count) + 1
        let scrWidth = self.view.frame.width
        self.scrollView.contentSize = CGSizeMake(CGFloat(pageSize) * scrWidth, 0)
        
        self.scrollView.addSubview(initHomeView(scrWidth))
        
        //탭 뷰 생성
        for var i = 1; i < pageSize; i++
        {
            let tag = g_rs_Strings._tab_text[i-1]
            self.scrollView.addSubview(initTabView(tag!, scrWidth: scrWidth, idx: i))
        }
    }

    func initHomeView(scrWidth: CGFloat) -> UIScrollView{
        //ScrollView 생성
        var event_count:Int?
        var total_contents_rows:Int = 0
        let content_height = 3/2 * self.view.frame.width/2
        let event_title_height = 64
        
        let eventScrollView = UIScrollView()
        eventScrollView.frame =  CGRectMake(0, 0, self.view.frame.width , self.scrollView.frame.height)
        eventScrollView.scrollEnabled = true
        
        //상단 배너 뷰
        let bannerView = UIImageView()
        bannerView.frame = CGRectMake(0, 0, self.view.frame.width, 6/16*self.view.frame.width)
        bannerView.backgroundColor = UIColor.whiteColor()
        eventScrollView.addSubview(bannerView)
        
        //case 0 -> 홈 화면 -> Item_Event CoreData값 로드
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = app.managedObjectContext
        let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Event")
        request.predicate = NSPredicate(format: "item_info == nil")
        
        let filter_result = (try! context.executeFetchRequest(request)) as! [Item_Event]
        event_count = filter_result.count
        NSLog("event_count : %d", filter_result.count)
        var n = 0
        //이벤트 갯수 만큼 루프
        for result in filter_result {
            var itemInfo = [rsCItems]()
            let euid = result.euid!
            if euid.isEmpty {
                event_count! -= 1
            } else {
                let itemsContext:NSManagedObjectContext = app.managedObjectContext
                let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Info")
                request.returnsObjectsAsFaults = false
                
                var results: NSArray = []
                do {
                    results = try itemsContext.executeFetchRequest(request)
                    // success ...
                    //모든 아이템 정보 조회
                    for item in results {
                        let tmp = item as! Item_Info
                        for event in tmp.item_event! {
                            //현재 이벤트 진행중인 카테고리에 해당하는 아이템 검색
                            if euid.isEqual(event.valueForKey("euid")) {
                                let tmpItem = rsCItems()
                                tmpItem._iuid = item.valueForKey("iuid") as? String
                                tmpItem._name = item.valueForKey("name") as? String
                                tmpItem._image = item.valueForKey("image") as? String
                                tmpItem._selling = item.valueForKey("selling") as? String
                                tmpItem._purchase = item.valueForKey("purchase") as? String
                                tmpItem._tag = MatchingTagViaIUID(tmpItem._iuid!)
                                itemInfo.append(tmpItem)
                            }
                        }
                    }
                } catch let error as NSError {
                    // failure
                    print("Fetch failed: \(error.localizedDescription)")
                }
                
                NSLog("event_item_count : %d", itemInfo.count)
               
                //iuid순서로 정렬
                itemInfo = itemInfo.sort { (element1, element2) -> Bool in
                    return element1._iuid < element2._iuid
                }
                
                let eventView = EventView()
                let viewHeight = (content_height * CGFloat((itemInfo.count / 2) + (itemInfo.count % 2))) + (8 * CGFloat((itemInfo.count / 2) + (itemInfo.count % 2))) + CGFloat(event_title_height) + 8
                let y_Position = ((content_height + 8) * CGFloat(total_contents_rows)) + bannerView.frame.height + 8 + ((CGFloat(event_title_height) + 8 ) * CGFloat(n))
                eventView.frame = CGRectMake(0, y_Position, self.view.frame.width, viewHeight)
                total_contents_rows += ((itemInfo.count / 2) + (itemInfo.count % 2))
                eventView.initView(result.valueForKey("name") as! String, value: itemInfo, count: itemInfo.count)
                eventScrollView.addSubview(eventView)
                
                n += 1
            }
        }
        
        if event_count == 0 {
            NSLog("load none message")
            let noneView = UIView()
            noneView.frame = CGRectMake(0, bannerView.frame.height, self.view.frame.width, self.scrollView.frame.height - bannerView.frame.height)
            let noneLabel = UILabel()
            noneLabel.frame = CGRectMake(0, noneView.frame.height/2, noneView.frame.width, 20)
            noneLabel.text = g_rs_Strings._event_none_item
            noneLabel.textAlignment = .Center
            noneView.addSubview(noneLabel)
            eventScrollView.addSubview(noneView)
            eventScrollView.contentSize = CGSizeMake(self.view.frame.width, bannerView.frame.height + noneView.frame.height)
        } else {
            eventScrollView.contentSize = CGSizeMake(self.view.frame.width, bannerView.frame.height + 8 + ((content_height + 8) * CGFloat(total_contents_rows)) + (CGFloat(event_title_height + 8) * CGFloat(event_count!)))
        }
        NSLog("home view loading complete")
        return eventScrollView
    }
    
    func initTabView(tag: String, scrWidth: CGFloat, idx: Int, subTagIdx: Int=0) -> UIScrollView {
        //ScrollView 생성
        var tag_count:Int?
        let canvasScrollView = UIScrollView()
        canvasScrollView.tag = 100*idx
        canvasScrollView.frame =  CGRectMake(CGFloat(idx) * scrWidth, 0, self.view.frame.width , self.scrollView.frame.height)
        canvasScrollView.scrollEnabled = true
        
        let subTagMenuView = SubTagMenu()
        let subTagMenuHeight:CGFloat = 40
        let subTagDispView = SubTagDisp()
        
        //태그에 해당하는 아이템 필터
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = app.managedObjectContext
        let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Info")
        request.returnsObjectsAsFaults = false

        var results: NSArray = []
        var itemInfo = [rsCItems]()
        do {
            results = try context.executeFetchRequest(request)
            // success ...
            for item in results {
                let tmp = item as! Item_Info
                for item_tag in tmp.item_tag! {
                    if tag.isEqual(item_tag.valueForKey("name")) {
                        let tmpItem = rsCItems()
                        tmpItem._iuid = item.valueForKey("iuid") as? String
                        tmpItem._name = item.valueForKey("name") as? String
                        tmpItem._image = item.valueForKey("image") as? String
                        tmpItem._selling = item.valueForKey("selling") as? String
                        tmpItem._purchase = item.valueForKey("purchase") as? String
                        tmpItem._tag = (MatchingTagViaIUID(tmpItem._iuid!)).sort()
                        itemInfo.append(tmpItem)
                    }
                }
            }
            //iuid 순서로 정렬
            itemInfo = itemInfo.sort { (element1, element2) -> Bool in
                return element1._iuid < element2._iuid
            }
            tag_count = itemInfo.count
            
            //서브 카테고리 추출
            var subTag = [String]()
            for item in itemInfo {
                if (subTag.indexOf(item._tag[1]) == nil) {
                    subTag.append(item._tag[1])
                }
            }
            subTag = subTag.sort()
            //전체보기 메뉴를 위해 임의로 서브 태그 추가
            subTag.insert("st000", atIndex: 0)
            
            let subTagRows = ((subTag.count - 1) / 3) + 1
            
            //상단 서브 카테고리 뷰
            subTagMenuView.frame = CGRectMake(8, 8, self.view.frame.width - 16, subTagMenuHeight * CGFloat(subTagRows))
            subTagMenuView.initView(subTag, height:subTagMenuHeight, viewTag:canvasScrollView.tag)
            subTagMenuView.backgroundColor = UIColor.whiteColor()

            for n in 0...subTagMenuView.button.count-1 {
                subTagMenuView.button[n].addTarget(self, action: Selector("subTabButtonTapped:"), forControlEvents: .TouchUpInside)
            }
            subTagMenuView.button[subTagIdx].setTitleColor(UIColorFromRGB(g_rs_Values.colorDeepOrange), forState: .Normal)
            canvasScrollView.addSubview(subTagMenuView)
          
            let content_height = 3/2 * self.view.frame.width/2
            
            if subTagIdx == 0 { //전체보기
                let viewHeight = (content_height * CGFloat((itemInfo.count / 2) + (itemInfo.count % 2))) + (8 * CGFloat((itemInfo.count / 2) + (itemInfo.count % 2)))
                
                subTagDispView.frame = CGRectMake(0, subTagMenuView.frame.origin.y + subTagMenuView.frame.height + 8, self.view.frame.width, viewHeight)
                subTagDispView.initView(itemInfo, count: itemInfo.count)
                canvasScrollView.addSubview(subTagDispView)
            } else {
                let selectedSubTag = subTag[subTagIdx]
                //itemInfo중에서 선택된 태그에 해당하는 아이템만을 필터
                let selectedItemInfo = itemInfo.filter{$0._tag[1].isEqual(selectedSubTag)}
                
                let viewHeight = (content_height * CGFloat((selectedItemInfo.count / 2) + (selectedItemInfo.count % 2))) + (8 * CGFloat((selectedItemInfo.count / 2) + (selectedItemInfo.count % 2)))
                
                subTagDispView.frame = CGRectMake(0, subTagMenuView.frame.origin.y + subTagMenuView.frame.height + 8, self.view.frame.width, viewHeight)
                subTagDispView.initView(selectedItemInfo, count: selectedItemInfo.count)
                canvasScrollView.addSubview(subTagDispView)
            }
            
            NSLog("%@_item_count : %d", tag, tag_count!)
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }

        if tag_count == 0 {
            NSLog("load none message")
            let noneView = UIView()
            noneView.frame = CGRectMake(0, 0, self.view.frame.width, self.scrollView.frame.height)
            let noneLabel = UILabel()
            noneLabel.frame = CGRectMake(0, noneView.frame.height/2, noneView.frame.width, 20)
            noneLabel.text = g_rs_Strings._content_none_item
            noneLabel.textAlignment = .Center
            noneView.addSubview(noneLabel)
            canvasScrollView.addSubview(noneView)
            canvasScrollView.contentSize = CGSizeMake(self.view.frame.width, noneView.frame.height)
        } else {
            canvasScrollView.contentSize = CGSizeMake(self.view.frame.width, subTagDispView.frame.origin.y + subTagDispView.frame.height)
        }
        
        NSLog("%@ tab view loading complete", tag)
        return canvasScrollView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        
        if currentPage < 0 {
            scrollView.scrollRectToVisible(CGRectMake(scrollView.frame.maxX * 3, 0, self.view.frame.width, self.view.frame.height), animated: false)
        } else if ( currentPage > 3) {
            scrollView.scrollRectToVisible(CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), animated: false)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        self.customTabmenu.selection(currentPage)
    }
    
    func homeButtonTapped(sender: UIButton!) {
        self.customTabmenu.selection(0)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func tabButtonTapped(sender: UIButton!) {
        self.customTabmenu.selection(sender.tag-99)
        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.maxX * CGFloat(sender.tag-99) ,y: 0), animated: true)
    }
    
    func subTabButtonTapped(sender: UIButton!) {
        let index = self.scrollView.subviews.indexOf(self.scrollView.viewWithTag((sender.tag/100)*100)!)
        self.scrollView.subviews[index!].removeFromSuperview()
        subTagDispRefresh(sender.tag/100, subTagIdx: sender.tag%100)
    }
    
    func subTagDispRefresh(idx: Int, subTagIdx: Int) {
        let scrWidth = self.view.frame.width
        
        let tag = g_rs_Strings._tab_text[idx-1]
        NSLog("refresh")
        self.scrollView.addSubview(initTabView(tag!, scrWidth: scrWidth, idx: idx, subTagIdx: subTagIdx))
    }        
}
