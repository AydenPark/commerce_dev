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
        self.customTabmenu.frame = CGRectMake(0, customView.frame.height + 20, self.view.frame.width, 44)
        self.customTabmenu.initView(self.view.frame.size)
        self.view.addSubview(self.customTabmenu)
        
        //init custom tabbar button event
        self.customTabmenu.homeButton.addTarget(self, action: "homeButtonTapped", forControlEvents: .TouchUpInside)
        self.customTabmenu.tab1Button.addTarget(self, action: "tab1ButtonTapped", forControlEvents: .TouchUpInside)
        self.customTabmenu.tab2Button.addTarget(self, action: "tab2ButtonTapped", forControlEvents: .TouchUpInside)
        self.customTabmenu.tab3Button.addTarget(self, action: "tab3ButtonTapped", forControlEvents: .TouchUpInside)
        
        //scrollview -> content view
        self.scrollView = UIScrollView(frame: CGRectMake(0, customView.frame.height + 20 + self.customTabmenu.frame.height, self.view.frame.width, self.view.frame.height - (customView.frame.height + 20 + self.customTabmenu.frame.height)))
        self.scrollView.backgroundColor = UIColor.blueColor()
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
        
        //test
   //     test_Items?.initData()
        
        let app: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = app.managedObjectContext
        let request: NSFetchRequest = NSFetchRequest(entityName: "Item_Info")
        request.returnsObjectsAsFaults = false
        print(request)
        
 //       let iuid = "fr001"
 //       request.predicate = NSPredicate(format: "iuid == %@", iuid as NSString)

        var error: NSError?
        var results: NSArray = []
        
        do {
            results = try context.executeFetchRequest(request)
            // success ...
            print(results.count)
            for item in results {
                print(item.name)
            }
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        let pageSize = 4
        let scrWidth = self.view.frame.width, scrHeight = self.view.frame.height
        scrollView.contentSize = CGSizeMake(CGFloat(pageSize) * scrWidth, 0)
        
        for var i = 0; i < pageSize; i++
        {
            switch i {
            case 0:
                let listView = UIView()
                listView.frame = CGRectMake(CGFloat(i) * scrWidth, 0, self.view.frame.width , self.scrollView.frame.height)
                listView.backgroundColor = UIColor.whiteColor()
                self.scrollView.addSubview(listView)
            case 1:
                let listView = UIView()
                listView.frame = CGRectMake(CGFloat(i) * scrWidth, 0, self.view.frame.width , self.scrollView.frame.height)
                listView.backgroundColor = UIColor.blueColor()
                self.scrollView.addSubview(listView)
            case 2:
                let listView = UIView()
                listView.frame = CGRectMake(CGFloat(i) * scrWidth, 0, self.view.frame.width , self.scrollView.frame.height)
                listView.backgroundColor = UIColor.blackColor()
                self.scrollView.addSubview(listView)
            case 3:
                let listView = UIView()
                listView.frame = CGRectMake(CGFloat(i) * scrWidth, 0, self.view.frame.width , self.scrollView.frame.height)
                listView.backgroundColor = UIColor.yellowColor()
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
