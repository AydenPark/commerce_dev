//
//  Main_ViewController.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 3..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var navItem: UINavigationItem!
    
    private var customTabmenu = CustomTabmenu()
    private var scrollView: UIScrollView!
    
    var scrollPages = [UILabel]()
    override func viewDidLoad() {
        
        let navWidth = self.navigationController?.navigationBar.frame.width
        let customView:UIView = UIView(frame: CGRectMake(0, 0, navWidth!, 44))
        
        //margin 16px, icon 36, margin 16px => 68 x 2 = 136
        let titleLabel:UILabel = UILabel(frame: CGRectMake(0, 0, (customView.frame.width - 136) * 0.4 - 8, 44))
        titleLabel.text = rs_Strings?._main_navi_title
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        //modify searchBar
        var searchBar:UISearchBar = UISearchBar() //create searchBar
        searchBar.searchBarStyle = UISearchBarStyle.Minimal
        searchBar.placeholder = rs_Strings?._main_searchbar_ph
        var textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField //change text color
        textFieldInsideSearchBar?.textColor = UIColor.whiteColor()
        var textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.valueForKey("placeholderLabel") as? UILabel //change placeholder color
        textFieldInsideSearchBarLabel?.textColor = UIColor.whiteColor()
        let image: UIImage = UIImage(named: "ic_search")! //change search icon
        searchBar.setImage(image, forSearchBarIcon: UISearchBarIcon.Search, state: UIControlState.Normal)
        
        //view for searchBar
        let searchBarView:UIView = UIView(frame: CGRectMake((customView.frame.width - 136) * 0.4 + 8, 0, (customView.frame.width - 136) * 0.6 - 8, 44))
        searchBarView.addSubview(searchBar)
        searchBar.sizeToFit()
        
        customView.addSubview(titleLabel)
        customView.addSubview(searchBarView)
        self.navigationItem.titleView = customView

        //update datas from DB
        pc_UpdateDB?.updateEventsData()
        pc_UpdateDB?.updateTagsData()
        pc_UpdateDB?.updateItemsData()
        
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
        

        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        //pageSize => 메뉴 탭 갯수
        let pageSize = (rs_Strings?._tab_text.count)! + 1
        let scrWidth = self.view.frame.width, scrHeight = self.view.frame.height
        scrollView.contentSize = CGSizeMake(CGFloat(pageSize) * scrWidth, 0)
        
        for var i = 0; i < pageSize; i++
        {
            switch i {
            case 0:
                //ScrollView 생성
                var event_count:Int?
                var total_contents_rows:Int = 0
                var content_height = 3/2 * self.view.frame.width/2
                var event_title_height = 64
                
                var eventScrollView = UIScrollView()
                eventScrollView.frame =  CGRectMake(CGFloat(i) * scrWidth, 0, self.view.frame.width , self.scrollView.frame.height)
                eventScrollView.scrollEnabled = true
                
                //상단 배너 뷰
                var bannerView = UIImageView()
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
                    var itemValue = [rsCItems]()
                    var euid = result.euid!
                    if euid.isEmpty {
                        event_count! -= 1
                    } else {
                        let itemsContext:NSManagedObjectContext = app.managedObjectContext
                        var itemsDescription = NSEntityDescription.entityForName("Item_Info", inManagedObjectContext: itemsContext)
                        var itemsData = Item_Info(entity: itemsDescription!, insertIntoManagedObjectContext: itemsContext)
                        let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Info")
                        request.returnsObjectsAsFaults = false

                        var error: NSError?
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
                                        var tmpItem = rsCItems()
                                        tmpItem._name = item.valueForKey("name") as! String
                                        tmpItem._image = item.valueForKey("image") as! String
                                        tmpItem._selling = item.valueForKey("selling") as! String
                                        tmpItem._purchase = item.valueForKey("purchase") as! String
                                        itemValue.append(tmpItem)
                                    }
                                }
                            }
                        } catch let error as NSError {
                            // failure
                            print("Fetch failed: \(error.localizedDescription)")
                        }
                        
                        NSLog("event_item_count : %d", itemValue.count)
                        
                        var eventView = EventView()
                        var viewHeight = (content_height * CGFloat((itemValue.count / 2) + (itemValue.count % 2))) + (8 * CGFloat((itemValue.count / 2) + (itemValue.count % 2))) + CGFloat(event_title_height) + 8
                        var y_Position = ((content_height + 8) * CGFloat(total_contents_rows)) + bannerView.frame.height + 8 + ((CGFloat(event_title_height) + 8 ) * CGFloat(n))
                        eventView.frame = CGRectMake(0, y_Position, self.view.frame.width, viewHeight)
                        total_contents_rows += ((itemValue.count / 2) + (itemValue.count % 2))
                        
                        eventView.initView(result.valueForKey("name") as! String, value: itemValue, count: itemValue.count)
                        eventScrollView.addSubview(eventView)
                        
                        n += 1
                    }
                }
                
                if event_count == 0 {
                    NSLog("load none message")
                    var noneView = UIView()
                    noneView.frame = CGRectMake(0, bannerView.frame.height, self.view.frame.width, self.scrollView.frame.height - bannerView.frame.height)
                    var noneLabel = UILabel()
                    noneLabel.frame = CGRectMake(0, noneView.frame.height/2, noneView.frame.width, 20)
                    noneLabel.text = "현재 이벤트중인 상품이 존재하지 않습니다."
                    noneLabel.textAlignment = .Center
                    noneView.addSubview(noneLabel)
                    eventScrollView.addSubview(noneView)
                    eventScrollView.contentSize = CGSizeMake(self.view.frame.width, bannerView.frame.height + noneView.frame.height)
                } else {
                    eventScrollView.contentSize = CGSizeMake(self.view.frame.width, bannerView.frame.height + 8 + ((content_height + 8) * CGFloat(total_contents_rows)) + (CGFloat(event_title_height + 8) * CGFloat(event_count!)))
                }
                NSLog("home view loading complete")
                self.scrollView.addSubview(eventScrollView)
            case 1:
                let listView = UIView()
                listView.frame = CGRectMake(CGFloat(i) * scrWidth, 0, self.view.frame.width , self.scrollView.frame.height)
               // listView.backgroundColor = UIColor.blueColor()
                self.scrollView.addSubview(listView)
            case 2:
                let listView = UIView()
                listView.frame = CGRectMake(CGFloat(i) * scrWidth, 0, self.view.frame.width , self.scrollView.frame.height)
              //  listView.backgroundColor = UIColor.blackColor()
                self.scrollView.addSubview(listView)
            case 3:
                let listView = UIView()
                listView.frame = CGRectMake(CGFloat(i) * scrWidth, 0, self.view.frame.width , self.scrollView.frame.height)
               // listView.backgroundColor = UIColor.yellowColor()
                self.scrollView.addSubview(listView)
            default:
                return
            }
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        var currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        
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
}
