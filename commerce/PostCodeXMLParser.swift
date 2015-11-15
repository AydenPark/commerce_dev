//
//  PostCodeXMLParser.swift
//  commerce
//
//  Created by jigwan on 2015. 11. 14..
//  Copyright © 2015년 STRUCEL. All rights reserved.
//

import Foundation
import UIKit


public class PostCodeXMLParser: NSObject, NSXMLParserDelegate {
    var muArr = NSMutableArray()
    var strAddr: String! = ""
    var strAddrRoad1: String! = ""
    var strAddrRoad2: String! = ""
    var strPostcode: String! = ""
    var strVal: String! = ""
    
        
    func getPostCode (strTarget:NSString, strDong: NSString, strReg: NSString) -> NSMutableArray{
        let strURL = "http://biz.epost.go.kr/KpostPortal/openapi"
        
        let responseString:NSString = strDong.stringByAddingPercentEscapesUsingEncoding(0x80000940)!
        let strQuery = strURL.stringByAppendingString("?regkey="+(strReg as String)+"&target="+(strTarget as String)+"&query="+((responseString) as String))
        let url = NSURL(string: strQuery)
        print(url)
        let xmlParser = NSXMLParser(contentsOfURL: url!)!
        xmlParser.delegate = self
        xmlParser.parse()
        
        return muArr
    }
    
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if(elementName.isEqual("address") || elementName.isEqual("postcd")) {
            NSLog("didStartElemet elementName: %@", elementName)
        }
    }
    
    public func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        NSLog("didEndElemet elementName: %@", elementName)
        if(elementName.isEqual("address")) {
            self.strAddr = self.strVal
        }
        
        if(elementName.isEqual("lnmAddress")) {
            self.strAddrRoad1 = self.strVal
        }
        
        if(elementName.isEqual("rnAddress")) {
            self.strAddrRoad2 = self.strVal
        }
        
        if(elementName.isEqual("postcd")) {
            self.strPostcode = self.strVal
        }
        
        if(elementName.isEqual("item")) {
            let dic: NSDictionary = ["postcode":self.strPostcode, "address":self.strAddr, "addressRoad1":self.strAddrRoad1, "addressRoad2":self.strAddrRoad2]
            self.muArr.addObject(dic)
        }
    }
    
    public func parser(parser: NSXMLParser, foundCharacters string: String) {
        self.strVal = string
        NSLog("string: %@",string);
    }
}
