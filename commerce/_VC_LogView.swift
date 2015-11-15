//
//  ViewController.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 3..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UIWebViewDelegate, AddressDelegate{
    
    private var pageControl: UIPageControl!
    private var scrollView: UIScrollView!
    private var contentView: UIView!

    //SubViews Page1
    let subContentLabel = UILabel()
    let nameTextField = UITextField()
    let phoneTextField = UITextField()
    let addressTextField = UITextField()
    let addressTextField2 = UITextField()
    let searchButton = UIButton(type: .System)
    let nextButton = UIButton(type: .System)

    //SubViews Page2
    let startButton = UIButton(type: .System)
    let backButton = UIButton(type: .System)
    let confirmView = UIView()
    
    let bgnView = UIView()
    var pageSize = 2
    var nextButtonY: CGFloat!
    var agreeCheck = false
    
    var userName: String! = ""
    var userPhone: String! = ""
    var userAddress1: String! = ""
    var userAddress2: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView = UIView(frame: CGRectMake(0, self.view.frame.height * 0.3, self.view.frame.width, self.view.frame.height * 0.7))
        self.view.addSubview(self.contentView)
        //scrollview -> content view
        self.scrollView = UIScrollView(frame: CGRectMake(0, 0, self.contentView.frame.width, self.contentView.frame.height))
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.scrollView.showsHorizontalScrollIndicator = false;
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.pagingEnabled = true
        self.scrollView.delegate = self
        self.contentView.addSubview(self.scrollView)
        
        let scrWidth = self.contentView.frame.width
        self.pageControl = UIPageControl(frame: CGRectMake(0, self.view.frame.maxY-50, scrWidth, 50))
        self.pageControl.backgroundColor = UIColor.clearColor()
        self.pageControl.numberOfPages = self.pageSize
        self.pageControl.currentPage = 0
        self.pageControl.userInteractionEnabled = false
        self.pageControl.currentPageIndicatorTintColor = UIColorFromRGB(g_rs_Values.colorDeepOrange)
        self.pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        
        self.view.addSubview(self.pageControl)
        initView(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
        super.touchesBegan(touches, withEvent:event)
    }
    
    func initView(index: Int = 0) {
        let scrWidth = self.contentView.frame.width
        self.scrollView.contentSize = CGSizeMake(scrWidth, 0)
        if index == 0 {
            self.subContentLabel.frame = CGRectMake(CGFloat(index) * scrWidth, 0, scrWidth, 56)
            let attributedText = NSMutableAttributedString(string: g_rs_Strings._tutorial_sub_content1!, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 16)!])
            self.subContentLabel.attributedText = attributedText
            self.subContentLabel.textColor = UIColor.darkTextColor()
            self.subContentLabel.textAlignment = .Center
            self.subContentLabel.numberOfLines = 0
            self.scrollView.addSubview(self.subContentLabel)
            
            self.nameTextField.frame = CGRectMake(16, self.subContentLabel.frame.origin.y + self.subContentLabel.frame.height + 16, self.contentView.frame.width - 32, 48)
            self.nameTextField.placeholder = g_rs_Strings._tutorial_name_tf
            self.nameTextField.layer.cornerRadius = 0.1 * self.nameTextField.bounds.size.height
            self.nameTextField.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.nameTextField.addTarget(self, action: "textFieldEditing:", forControlEvents: UIControlEvents.EditingDidBegin)
            self.nameTextField.addTarget(self, action: "textFieldChanging:", forControlEvents: UIControlEvents.EditingChanged)
            self.nameTextField.tag = 1
            self.nameTextField.delegate = self
            self.nameTextField.setTextLeftPadding(16)
            self.scrollView.addSubview(self.nameTextField)
            
            self.phoneTextField.frame = CGRectMake(16, self.nameTextField.frame.origin.y + self.nameTextField.frame.height + 8, self.contentView.frame.width - 32, 48)
            self.phoneTextField.placeholder = g_rs_Strings._tutorial_phone_tf
            self.phoneTextField.layer.cornerRadius = 0.1 * self.nameTextField.bounds.size.height
            self.phoneTextField.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.phoneTextField.keyboardType = UIKeyboardType.PhonePad
            self.phoneTextField.addTarget(self, action: "textFieldEditing:", forControlEvents: UIControlEvents.EditingDidBegin)
            self.phoneTextField.addTarget(self, action: "textFieldChanging:", forControlEvents: UIControlEvents.EditingChanged)
            self.phoneTextField.tag = 2
            self.phoneTextField.setTextLeftPadding(16)
            self.scrollView.addSubview(self.phoneTextField)
            
            self.addressTextField.frame = CGRectMake(16, self.phoneTextField.frame.origin.y + self.phoneTextField.frame.height + 8, self.contentView.frame.width - 112, 48)
            self.addressTextField.placeholder = g_rs_Strings._tutorial_address_tf
            self.addressTextField.layer.cornerRadius = 0.1 * self.nameTextField.bounds.size.height
            self.addressTextField.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.addressTextField.enabled = false
            self.addressTextField.text = self.userAddress1
            self.addressTextField.delegate = self
            self.addressTextField.setTextLeftPadding(16)
            self.scrollView.addSubview(self.addressTextField)
            
            self.searchButton.frame = CGRectMake(self.addressTextField.frame.origin.x + self.addressTextField.frame.width + 8, self.phoneTextField.frame.origin.y + self.phoneTextField.frame.height + 8, 72, 48)
            self.searchButton.setTitle("검색", forState: .Normal)
            self.searchButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            self.searchButton.layer.cornerRadius = 0.1 * self.nameTextField.bounds.size.height
            self.searchButton.backgroundColor = UIColorFromRGB(g_rs_Values.colorDeepOrange)
            self.searchButton.addTarget(self, action: Selector("searchButtonTapped:"), forControlEvents: .TouchUpInside)
            self.scrollView.addSubview(self.searchButton)

            self.addressTextField2.frame = CGRectMake(16, self.addressTextField.frame.origin.y + self.addressTextField.frame.height + 8, self.contentView.frame.width - 32, 48)
            self.addressTextField2.layer.cornerRadius = 0.1 * self.nameTextField.bounds.size.height
            self.addressTextField2.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.addressTextField2.addTarget(self, action: "textFieldEditing:", forControlEvents: UIControlEvents.EditingDidBegin)
            self.addressTextField2.addTarget(self, action: "textFieldChanging:", forControlEvents: UIControlEvents.EditingChanged)
            self.addressTextField2.enabled = true
            self.addressTextField2.tag = 3
            self.addressTextField2.setTextLeftPadding(16)
            self.scrollView.addSubview(self.addressTextField2)
            
            let buttonY1 = (self.addressTextField.frame.origin.y + self.addressTextField.frame.height) + (self.contentView.frame.height - (self.addressTextField.frame.origin.y + self.addressTextField.frame.height))/2
            let buttonY2 = self.contentView.frame.height - 120
            self.nextButtonY = buttonY1 > buttonY2 ? buttonY1 : buttonY2
            self.nextButton.frame = CGRectMake(self.contentView.frame.width * 0.2, self.nextButtonY, self.contentView.frame.width * 0.6, 48)
            self.nextButton.setTitle("다음", forState: .Normal)
            self.nextButton.layer.cornerRadius = 0.3 * self.nextButton.bounds.size.height
            self.nextButton.tintColor = UIColor.whiteColor()
            self.nextButton.backgroundColor = UIColorFromRGB(g_rs_Values.colorDeepOrange)
            self.nextButton.addTarget(self, action: Selector("nextButtonTapped:"), forControlEvents: .TouchUpInside)
            self.scrollView.addSubview(self.nextButton)
        } else if index == 1 {
            self.subContentLabel.frame = CGRectMake(CGFloat(index) * scrWidth, 0, scrWidth, 56)
            let attributedText = NSMutableAttributedString(string: g_rs_Strings._tutorial_sub_content2!, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 16)!])
            self.subContentLabel.attributedText = attributedText
            self.subContentLabel.textColor = UIColor.darkTextColor()
            self.subContentLabel.textAlignment = .Center
            self.subContentLabel.numberOfLines = 0
            self.scrollView.addSubview(self.subContentLabel)
            
            self.startButton.frame = CGRectMake(CGFloat(index) * scrWidth + self.contentView.frame.width * 0.2, self.nextButtonY, self.contentView.frame.width * 0.6, 48)
            self.startButton.setTitle("이용하기", forState: .Normal)
            self.startButton.layer.cornerRadius = 0.3 * self.startButton.bounds.size.height
            self.startButton.tintColor = UIColor.whiteColor()
            self.startButton.backgroundColor = UIColorFromRGB(g_rs_Values.colorDeepOrange)
            self.startButton.addTarget(self, action: Selector("startButtonTapped:"), forControlEvents: .TouchUpInside)
            self.scrollView.addSubview(self.startButton)
            
            self.backButton.frame = CGRectMake(CGFloat(index) * scrWidth + 8, self.nextButtonY + 11, 26, 26)
            self.backButton.setImage(UIImage(named: "btn_back"), forState: .Normal)
            self.backButton.tintColor = UIColorFromRGB(g_rs_Values.colorDeepOrange)
            self.backButton.addTarget(self, action: Selector("backButtonTapped:"), forControlEvents: .TouchUpInside)
            self.scrollView.addSubview(self.backButton)
            
            self.confirmView.frame = CGRectMake(CGFloat(index) * scrWidth + 16, self.subContentLabel.frame.maxY+8, self.contentView.frame.width - 32, (self.startButton.frame.minY - self.subContentLabel.frame.maxY) - 24)
            self.confirmView.layer.cornerRadius = 0.3 * self.startButton.bounds.size.height
            self.confirmView.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
            self.confirmView.layer.borderWidth = 1
            self.confirmView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            
            let inforVIew = UIView(frame: CGRectMake(0, 0, self.confirmView.frame.width, self.confirmView.frame.height - 52))
            
            let nameLabel = UILabel(frame: CGRectMake(16, 0, self.confirmView.frame.width - 32, inforVIew.frame.height*0.3))
            nameLabel.text = "이름 : " + self.userName
            inforVIew.addSubview(nameLabel)
            
            let phoneLabel = UILabel(frame: CGRectMake(16, inforVIew.frame.height*0.3, self.confirmView.frame.width - 32, inforVIew.frame.height*0.3))
            phoneLabel.text = "연락처 : " + self.userPhone
            inforVIew.addSubview(phoneLabel)
            
            let addressLabel = UILabel(frame: CGRectMake(16, inforVIew.frame.height*0.6, self.confirmView.frame.width - 32, inforVIew.frame.height*0.3))
            addressLabel.text = "주소 : " + self.userAddress1 + "\n" + self.userAddress2
            addressLabel.numberOfLines = 0
            inforVIew.addSubview(addressLabel)
            
            self.confirmView.addSubview(inforVIew)
            
            let agree = UIButton(type: .Custom)
            agree.frame = CGRectMake(0, self.confirmView.frame.height - 52, self.confirmView.frame.width, 36)
            agree.setImage(UIImage(named: "btn_uncheck"), forState: .Normal)
            agree.setTitle("이용약관 및 개인정보 활용 동의", forState: .Normal)
            agree.setTitleColor(UIColorFromRGB(g_rs_Values.colorDeepOrange), forState: .Normal)
            agree.addTarget(self, action: Selector("checkButtonTapped:"), forControlEvents: .TouchUpInside)
            self.confirmView.addSubview(agree)
            
            self.scrollView.addSubview(self.confirmView)
        }
        
        self.contentView.addSubview(self.scrollView)
    }
    
    func dismissView(index: Int = 0) {
        if index == 0 {
            self.subContentLabel.removeFromSuperview()
            self.nameTextField.removeFromSuperview()
            self.phoneTextField.removeFromSuperview()
            self.addressTextField.removeFromSuperview()
            self.searchButton.removeFromSuperview()
            self.addressTextField2.removeFromSuperview()
            self.nextButton.removeFromSuperview()
        } else if index == 1 {
            self.subContentLabel.removeFromSuperview()
            self.startButton.removeFromSuperview()
            self.backButton.removeFromSuperview()
            self.confirmView.removeFromSuperview()
        }        
    }
    
    func backButtonTapped(sender: AnyObject) {
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
        
        self.scrollView.contentOffset.x = 0
        dismissView(1)
        initView(0)
    }

    func nextButtonTapped(sender: UIButton) {
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
        if(!self.userName.isEmpty && !self.userPhone.isEmpty && !self.userAddress1.isEmpty && !self.userAddress2.isEmpty) {
            if (self.userPhone.length < 11) || (self.userPhone.length > 11) || (self.userPhone.substringToIndex(3) != "010"){
                self.view.makeToast(message: g_rs_Strings._tutorial_phone_error!, duration: 2, position: "center")
            } else {
                self.scrollView.contentOffset.x = self.contentView.frame.width
                dismissView(1)
                initView(1)
            }
        } else {
            self.view.makeToast(message: g_rs_Strings._tutorial_empty_error!, duration: 2, position: "center")
        }
    }
    
    func startButtonTapped(sender: UIButton) {
        if (self.agreeCheck) {
            //서버를 통해서 suid획득
            g_userInfo.User("test", name: self.userName, phone: self.userPhone, address1: self.userAddress1, address2: self.userAddress2)
            g_userInfo.setUserPrefs()
            
            prefs.setBool(true, forKey: "FirstLaunch")
            prefs.synchronize()
            
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            self.view.makeToast(message: g_rs_Strings._tutorial_agree_error!, duration: 2, position: "center")
        }
    }
    
    func checkButtonTapped(sender: UIButton) {
        self.agreeCheck = !self.agreeCheck
        
        if(self.agreeCheck) {
            sender.setImage(UIImage(named: "btn_check"), forState: .Normal)
        } else {
            sender.setImage(UIImage(named: "btn_uncheck"), forState: .Normal)
        }
    }
    
    func searchButtonTapped(sender: UIButton) {
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
        showAddressDlg()
    }
    
    func textFieldEditing(textField: UITextField) {
        self.view.frame.origin.y = -48
    }
    
    func textFieldChanging(textField: UITextField) {
        switch textField.tag {
        case 1:
            self.userName = textField.text
        case 2:
            self.userPhone = textField.text
        case 3:
            self.userAddress2 = textField.text!
        default:
            return
        }
    }
    
    func showAddressDlg() {
        let addrView = NSBundle.mainBundle().loadNibNamed("AddressView", owner: self, options: nil).first as? AddressView
        addrView?.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        addrView?.layer.borderColor = UIColor.darkGrayColor().CGColor
        addrView?.layer.borderWidth = 1
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("dismissAddrView:"), name:"AddrViewDismiss", object: nil)
        
        self.view.addSubview(addrView!)
    }
    
    func dismissAddrView(notification: NSNotification) {
        self.userAddress1 = g_userAddress
        dismissView(0)
        initView(0)
    }
    
    func selectedAddress(address: String) {
        var tokenStringArr = address.componentsSeparatedByString(" ")
        if tokenStringArr[3].isEmpty {
            g_userAddress = tokenStringArr[0] + " " + tokenStringArr[1] + " " + tokenStringArr[2]
        } else {
            g_userAddress = tokenStringArr[0] + " " + tokenStringArr[1] + " " + tokenStringArr[2] + " " + tokenStringArr[3]
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
}
