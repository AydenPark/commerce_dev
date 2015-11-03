//
//  Main_ViewController.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 3..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var navItem: UINavigationItem!
    
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
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
