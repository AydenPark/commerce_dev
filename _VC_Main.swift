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

        //custom tabbar
        self.customTabmenu.frame = CGRectMake(0, customView.frame.height + 20, self.view.frame.width, 45)
        self.customTabmenu.initView(self.view.frame.size)
        self.view.addSubview(self.customTabmenu)
        
        //init custom tabbar button event
        self.customTabmenu.homeButton.addTarget(self, action: "homeButtonTapped", forControlEvents: .TouchUpInside)
        self.customTabmenu.tab1Button.addTarget(self, action: "tab1ButtonTapped", forControlEvents: .TouchUpInside)
        self.customTabmenu.tab2Button.addTarget(self, action: "tab2ButtonTapped", forControlEvents: .TouchUpInside)
        self.customTabmenu.tab3Button.addTarget(self, action: "tab3ButtonTapped", forControlEvents: .TouchUpInside)
        
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
        self.customTabmenu.selection(0)
        initView()
        
        rs_UpdateDB?.updateData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        //pageSize => 메뉴 탭 갯수
        let pageSize = 4
        let scrWidth = self.view.frame.width, scrHeight = self.view.frame.height
        scrollView.contentSize = CGSizeMake(CGFloat(pageSize) * scrWidth, 0)
        
        for var i = 0; i < pageSize; i++
        {
            switch i {
            case 0:
                //ScrollView 생성
                var event_count:Int?
                var total_contents_rows:Int = 0
                var content_height = 4/3 * self.view.frame.width/2
                var event_title_height = 48
                
                var eventScrollView = UIScrollView()
                eventScrollView.frame =  CGRectMake(CGFloat(i) * scrWidth, 0, self.view.frame.width , self.scrollView.frame.height)
                eventScrollView.scrollEnabled = true
                
                //case 0 -> 홈 화면 -> Item_Event CoreData값 로드
                let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context:NSManagedObjectContext = app.managedObjectContext
                let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Event")
                request.returnsObjectsAsFaults = false
                
                var error: NSError?
                var results: NSArray = []
                
                do {
                    results = try context.executeFetchRequest(request)
                    // success ...
                    //현재 이벤트 진행중인 카테고리 갯수
                    event_count = results.count
                    //이벤트 euid 획득
                    var n = 0
                    for item in results {
                        var euid = item.valueForKey("euid")! as! String
                        //현재 이벤트 진행중인 카테고리에 해당하는 아이템 검색
                        let joinContext:NSManagedObjectContext = app.managedObjectContext
                        let joinRequest: NSFetchRequest = NSFetchRequest(entityName: "Item_Join")
                        joinRequest.predicate = NSPredicate(format: "(euid = %@)", euid)
                        
                        var error: NSError?
                        var results: NSArray = []
                        
                        do {
                            results = try context.executeFetchRequest(joinRequest)

                            var eventView = EventView()
                            //카테고리 당 위치 = (개별 콘텐트 높이 * 콘텐트 줄 수) + (타이틀 영역 높이 * 현재 카테고리 순번)
                            //카테고리 당 영역 = (부모 뷰 너비, 개별 콘텐트 높이 * (카테고리에 포함된 아이템 갯수 / 2 + 카테고리에 포함된 아이템 갯수 % 2) + 타이틀 영역 높이
                            eventView.frame = CGRectMake(0, (content_height * CGFloat(total_contents_rows)) + (CGFloat(event_title_height)) * CGFloat(n), self.view.frame.width, (content_height * CGFloat((results.count / 2) + (results.count % 2))) + CGFloat(event_title_height))
                            
                            total_contents_rows += ((results.count / 2) + (results.count % 2))
                            
                            var itemValue = [rsCItems]()
                            var m = 0
                            for item in results {
                                var iuid = item.valueForKey("iuid") as! String
                                //iuid를 이용하여 아이템 코어 데이터로 부터 아이템 정보 획득
                                //현재 이벤트 진행중인 카테고리에 해당하는 아이템 검색
                                let itemContext:NSManagedObjectContext = app.managedObjectContext
                                let itemRequest: NSFetchRequest = NSFetchRequest(entityName: "Item_Info")
                                print(iuid)
                                itemRequest.predicate = NSPredicate(format: "(iuid = %@)", iuid)
                                var error: NSError?
                                var results: NSArray = []
                                
                                do {
                                    results = try itemContext.executeFetchRequest(itemRequest)
                                    var tmpItem = rsCItems()
                                    tmpItem._name = results[0].valueForKey("name") as! String
                                    tmpItem._image = results[0].valueForKey("image") as! String
                                    tmpItem._price = results[0].valueForKey("price") as! String
                                    tmpItem._origin = results[0].valueForKey("origin") as! String
                                    itemValue.append(tmpItem)
                                }
                                m += 1
                            }                            
                            
                            eventView.initView(item.valueForKey("title") as! String, value: itemValue, count: results.count)
                            eventScrollView.addSubview(eventView)
                        }
                        n += 1
                    }
                    
                } catch let error as NSError {
                    // failure
                    print("Fetch failed: \(error.localizedDescription)")
                }
                eventScrollView.contentSize = CGSizeMake(self.view.frame.width, (content_height * CGFloat(total_contents_rows)) + (CGFloat(event_title_height) * CGFloat(event_count!)))
                
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
    
    func homeButtonTapped() {
        self.customTabmenu.selection(0)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func tab1ButtonTapped() {
        self.customTabmenu.selection(1)
        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.maxX ,y: 0), animated: true)
    }
    
    func tab2ButtonTapped() {
        self.customTabmenu.selection(2)
        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.maxX*2, y: 0), animated: true)
    }
    
    func tab3ButtonTapped() {
        self.customTabmenu.selection(3)
        self.scrollView.setContentOffset(CGPoint(x: self.view.frame.maxX*3, y: 0), animated: true)
    }

}
