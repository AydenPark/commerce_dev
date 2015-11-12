//
//  ViewController.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 3..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UIWebViewDelegate {
    
    private var pageControl: UIPageControl!
    private var scrollView: UIScrollView!
    private var contentView: UIView!

    var pageSize = 2
    var nextButtonY: CGFloat!
    var agreeCheck = false
    
    var userName: String! = ""
    var userPhone: String! = ""
    var userAddress: String! = ""
    
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
        self.scrollView.directionalLockEnabled = true
        self.scrollView.delegate = self
        self.contentView.addSubview(self.scrollView)
        
        initView()
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
        self.scrollView.contentSize = CGSizeMake(CGFloat(pageSize) * scrWidth, 0)
        if index == 0 {
            let subContentLabel = UILabel(frame: CGRectMake(CGFloat(index) * scrWidth, 0, scrWidth, 56))
            let attributedText = NSMutableAttributedString(string: g_rs_Strings._tutorial_sub_content1!, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 16)!])
            subContentLabel.attributedText = attributedText
            subContentLabel.textColor = UIColor.darkTextColor()
            subContentLabel.textAlignment = .Center
            subContentLabel.numberOfLines = 0
            self.scrollView.addSubview(subContentLabel)
            
            let nameTextField = UITextField(frame: CGRectMake(16, subContentLabel.frame.origin.y + subContentLabel.frame.height + 16, self.contentView.frame.width - 32, 48))
            nameTextField.placeholder = g_rs_Strings._tutorial_name_tf
            nameTextField.layer.cornerRadius = 0.1 * nameTextField.bounds.size.height
            nameTextField.backgroundColor = UIColor.groupTableViewBackgroundColor()
            nameTextField.addTarget(self, action: "textFieldEditing:", forControlEvents: UIControlEvents.EditingDidBegin)
            nameTextField.addTarget(self, action: "textFieldChanging:", forControlEvents: UIControlEvents.EditingChanged)
            nameTextField.tag = 1
            nameTextField.delegate = self
            nameTextField.setTextLeftPadding(16)
            self.scrollView.addSubview(nameTextField)
            
            let phoneTextField = UITextField(frame: CGRectMake(16, nameTextField.frame.origin.y + nameTextField.frame.height + 8, self.contentView.frame.width - 32, 48))
            phoneTextField.placeholder = g_rs_Strings._tutorial_phone_tf
            phoneTextField.layer.cornerRadius = 0.1 * nameTextField.bounds.size.height
            phoneTextField.backgroundColor = UIColor.groupTableViewBackgroundColor()
            phoneTextField.keyboardType = UIKeyboardType.PhonePad
            phoneTextField.addTarget(self, action: "textFieldEditing:", forControlEvents: UIControlEvents.EditingDidBegin)
            phoneTextField.addTarget(self, action: "textFieldChanging:", forControlEvents: UIControlEvents.EditingChanged)
            phoneTextField.tag = 2
            phoneTextField.setTextLeftPadding(16)
            self.scrollView.addSubview(phoneTextField)
            
            let addressTextField = UITextField(frame: CGRectMake(16, phoneTextField.frame.origin.y + phoneTextField.frame.height + 8, self.contentView.frame.width - 112, 48))
            addressTextField.placeholder = g_rs_Strings._tutorial_address_tf
            addressTextField.layer.cornerRadius = 0.1 * nameTextField.bounds.size.height
            addressTextField.backgroundColor = UIColor.groupTableViewBackgroundColor()
            addressTextField.enabled = false
            addressTextField.delegate = self
            addressTextField.setTextLeftPadding(16)
            self.scrollView.addSubview(addressTextField)
            
            let searchButton = UIButton(type: .System)
            searchButton.frame = CGRectMake(addressTextField.frame.origin.x + addressTextField.frame.width + 8, phoneTextField.frame.origin.y + phoneTextField.frame.height + 8, 72, 48)
            searchButton.setTitle("검색", forState: .Normal)
            searchButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            searchButton.layer.cornerRadius = 0.1 * nameTextField.bounds.size.height
            searchButton.backgroundColor = UIColorFromRGB(g_rs_Values.colorDeepOrange)
            searchButton.addTarget(self, action: Selector("searchButtonTapped:"), forControlEvents: .TouchUpInside)
            self.scrollView.addSubview(searchButton)

            let addressTextField2 = UITextField(frame: CGRectMake(16, addressTextField.frame.origin.y + addressTextField.frame.height + 8, self.contentView.frame.width - 32, 48))
            addressTextField2.layer.cornerRadius = 0.1 * nameTextField.bounds.size.height
            addressTextField2.backgroundColor = UIColor.groupTableViewBackgroundColor()
            addressTextField2.enabled = false
            addressTextField2.setTextLeftPadding(16)
            self.scrollView.addSubview(addressTextField2)
            
            let nextButton = UIButton(type: .System)
            let buttonY1 = (addressTextField.frame.origin.y + addressTextField.frame.height) + (self.contentView.frame.height - (addressTextField.frame.origin.y + addressTextField.frame.height))/2
            let buttonY2 = self.contentView.frame.height - 120
            nextButtonY = buttonY1 > buttonY2 ? buttonY1 : buttonY2
            nextButton.frame = CGRectMake(self.contentView.frame.width * 0.2, nextButtonY, self.contentView.frame.width * 0.6, 48)
            nextButton.setTitle("다음", forState: .Normal)
            nextButton.layer.cornerRadius = 0.3 * nextButton.bounds.size.height
            nextButton.tintColor = UIColor.whiteColor()
            nextButton.backgroundColor = UIColorFromRGB(g_rs_Values.colorDeepOrange)
            nextButton.addTarget(self, action: Selector("nextButtonTapped:"), forControlEvents: .TouchUpInside)
            self.scrollView.addSubview(nextButton)
        } else if index == 1 {
            let subContentLabel = UILabel(frame: CGRectMake(CGFloat(index) * scrWidth, 0, scrWidth, 56))
            let attributedText = NSMutableAttributedString(string: g_rs_Strings._tutorial_sub_content2!, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 16)!])
            subContentLabel.attributedText = attributedText
            subContentLabel.textColor = UIColor.darkTextColor()
            subContentLabel.textAlignment = .Center
            subContentLabel.numberOfLines = 0
            self.scrollView.addSubview(subContentLabel)
            
            let startButton = UIButton(type: .System)
            startButton.frame = CGRectMake(CGFloat(index) * scrWidth + self.contentView.frame.width * 0.2, nextButtonY, self.contentView.frame.width * 0.6, 48)
            startButton.setTitle("이용하기", forState: .Normal)
            startButton.layer.cornerRadius = 0.3 * startButton.bounds.size.height
            startButton.tintColor = UIColor.whiteColor()
            startButton.backgroundColor = UIColorFromRGB(g_rs_Values.colorDeepOrange)
            startButton.addTarget(self, action: Selector("startButtonTapped:"), forControlEvents: .TouchUpInside)
            self.scrollView.addSubview(startButton)
            
            let confirmView = UIView(frame: CGRectMake(CGFloat(index) * scrWidth + 16, subContentLabel.frame.maxY+8, self.contentView.frame.width - 32, (startButton.frame.minY - subContentLabel.frame.maxY) - 24))
            confirmView.layer.cornerRadius = 0.3 * startButton.bounds.size.height
            confirmView.layer.borderColor = UIColor.groupTableViewBackgroundColor().CGColor
            confirmView.layer.borderWidth = 1
            confirmView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            
            let inforVIew = UIView(frame: CGRectMake(0, 0, confirmView.frame.width, confirmView.frame.height - 52))
            
            let nameLabel = UILabel(frame: CGRectMake(16, 0, confirmView.frame.width - 32, inforVIew.frame.height*0.3))
            nameLabel.text = "이름 : " + self.userName
            inforVIew.addSubview(nameLabel)
            
            let phoneLabel = UILabel(frame: CGRectMake(16, inforVIew.frame.height*0.3, confirmView.frame.width - 32, inforVIew.frame.height*0.3))
            phoneLabel.text = "연락처 : " + self.userPhone
            inforVIew.addSubview(phoneLabel)
            
            let addressLabel = UILabel(frame: CGRectMake(16, inforVIew.frame.height*0.6, confirmView.frame.width - 32, inforVIew.frame.height*0.3))
            addressLabel.text = "주소 : " + self.userAddress
            inforVIew.addSubview(addressLabel)
            
            confirmView.addSubview(inforVIew)
            
            let agree = UIButton(type: .Custom)
            agree.frame = CGRectMake(0, confirmView.frame.height - 52, confirmView.frame.width, 36)
            agree.setImage(UIImage(named: "btn_uncheck"), forState: .Normal)
            agree.setTitle("이용약관 및 개인정보 활용 동의", forState: .Normal)
            agree.setTitleColor(UIColorFromRGB(g_rs_Values.colorDeepOrange), forState: .Normal)
            agree.addTarget(self, action: Selector("checkButtonTapped:"), forControlEvents: .TouchUpInside)
            confirmView.addSubview(agree)
            
            self.scrollView.addSubview(confirmView)
        }
        
        self.contentView.addSubview(self.scrollView)
        
        pageControl = UIPageControl(frame: CGRectMake(0, self.view.frame.maxY-50, scrWidth, 50))
        pageControl.backgroundColor = UIColor.clearColor()
        pageControl.numberOfPages = pageSize
        pageControl.currentPage = 0
        pageControl.userInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColorFromRGB(g_rs_Values.colorDeepOrange)
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        
        self.view.addSubview(pageControl)

    }

    func nextButtonTapped(sender: UIButton) {
        if(!self.userName.isEmpty && !self.userPhone.isEmpty && !self.userAddress.isEmpty) {
            if (self.userPhone.length < 11) || (self.userPhone.length > 11) || (self.userPhone.substringToIndex(3) != "010"){
                self.view.makeToast(message: g_rs_Strings._tutorial_phone_error!, duration: 2, position: "center")
            } else {
                self.scrollView.contentOffset.x = self.contentView.frame.width
                initView(1)
            }
        } else {
            self.view.makeToast(message: g_rs_Strings._tutorial_empty_error!, duration: 2, position: "center")
        }
    }
    
    func startButtonTapped(sender: UIButton) {
        if (self.agreeCheck) {
            //서버를 통해서 suid획득
            g_userInfo.User("test", name: self.userName, phone: self.userPhone, address: self.userAddress)
            g_userInfo.setUserPrefs()
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
            self.userAddress = textField.text
        default:
            return
        }
    }
    
    func showAddressDlg() {
        let bgnView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        bgnView.backgroundColor = UIColor.darkGrayColor()
        bgnView.alpha = 0.7
        self.view.addSubview(bgnView)
        
        let addrViewHeight = self.view.frame.height * 0.7
        let addrView = NSBundle.mainBundle().loadNibNamed("AddressView", owner: self, options: nil).first as? AddressView
        addrView?.frame = CGRectMake(16, (self.view.frame.height - addrViewHeight)/2, self.view.frame.width - 32, addrViewHeight)
        addrView?.layer.borderColor = UIColor.darkGrayColor().CGColor
        addrView?.layer.borderWidth = 1
        self.view.addSubview(addrView!)
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("he")
    }
    
    func closeButtonTapped(sender: UIButton) {
//        for n in 500...502 {
            self.view.viewWithTag(500)?.removeFromSuperview()
  //      }
        sender.removeFromSuperview()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView)
    {
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
}
