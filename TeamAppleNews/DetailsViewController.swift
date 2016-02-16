//
//  DetailsViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 02/11/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
//

import UIKit
import iAd
import SafariServices

class DetailsViewController: UIViewController, UIWebViewDelegate, SFSafariViewControllerDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    
    var array1 = [String]()
    
    var titleText = String()
    
    var timer = NSTimer()
    var timer2 = NSTimer()
    
    var htmlString = String()
    var webViewString = String()
    
    var TAN = String()
    
    @IBOutlet var myWebView: UIWebView!
    
    var link: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myWebView.delegate = self
        
        myWebView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
        myWebView.opaque = false
        
        if let fetchURL = NSURL(string: self.link! ) {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(fetchURL) { (data, response, error) -> Void in
                
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let titleArray = webContent?.componentsSeparatedByString("<meta property=\"og:title\" content=\"")
                    if titleArray!.count > 0 {
                        let finalTitleArray = titleArray![1].componentsSeparatedByString("\" />")
                        let titleSummary = finalTitleArray[0].stringByReplacingOccurrencesOfString("&#039;", withString: "'")
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.titleLabel.text = titleSummary
                            self.titleText = titleSummary
                            //print(finalTitleArray[0])
                        })
                    }
                    
                    let textArray = webContent?.componentsSeparatedByString("<div class=\"blog-content\">")
                    if textArray!.count > 0 {
                        let finalTextArray = textArray![1].componentsSeparatedByString("<div class=\"blog-social  \">")
                        let textSummary = finalTextArray[0].stringByReplacingOccurrencesOfString("<img src=\"", withString: "<img src=\"http://www.futureappleceo.com")
                        //print(finalTextArray[0])
                        let textSummary2 = textSummary.stringByReplacingOccurrencesOfString("font-family:'Helvetica';", withString: "")
                        //print(finalTextArray[0])
                        self.htmlString = "<font face='SF UI Display' size='3'> \(textSummary2)"
                        //print(self.htmlString)
                        
                        if self.htmlString.rangeOfString("<div><div class=\"") != nil {
                            
                            let htmlArray = self.htmlString.componentsSeparatedByString("<div><div class=\"")
                            //print(htmlArray[1])
                            self.webViewString = "<fieldset class=\"attribute-fix\" style=\"border: 2px solid black\"> <legend align=\"center\"; style=\"padding: 0 10px;\"> \(htmlArray[0]) </legend> <div><div class=\(htmlArray[1]) </fieldset>"
                            self.myWebView.loadHTMLString(self.webViewString, baseURL: nil)
                            
                        } else {
                            
                            self.webViewString = self.htmlString
                            self.myWebView.loadHTMLString(self.webViewString, baseURL: nil)
                            let alert = UIAlertController(title: "Error Loading", message: "There was an error loading the custom format for this page, I displayed it like this for you...", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        }
                    }
                    
                }
            }
            task.resume()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("loading"), userInfo: nil, repeats: true)
        timer2 = NSTimer.scheduledTimerWithTimeInterval(9, target: self, selector: Selector("finish"), userInfo: nil, repeats: false)
        
        TAN = "TAN"
        
        self.canDisplayBannerAds = true
        let removeiAds = NSUserDefaults.standardUserDefaults().objectForKey("removeiAds") as! Bool!
        if (removeiAds != nil && removeiAds == true) {
            canDisplayBannerAds = false
        }
        if (removeiAds != nil && removeiAds == false) {
            self.canDisplayBannerAds = true
        }
        
    }
    
    func loading() {
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        //print(itemList)
        if (itemList?.count > 0) {
            array1 = (itemList?.valueForKey("itemTitle"))! as! [String]
            //print(array1)
            //print(titleText)
            if (array1.count > 0) {
                for i in 0...array1.count-1 {
                    if array1[i] == titleText {
                        //print(true)
                        saveButtom.title = "Saved"
                        saveButtom.enabled = false
                        timer.invalidate()
                    }
                }
                if array1.contains("\(titleText)") {
                    //print(true)
                    saveButtom.title = "Saved"
                    saveButtom.enabled = false
                    timer.invalidate()
                }
            }
        }
    
    }
    
    func finish() {
        timer.invalidate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        //print(itemList)
        if (itemList?.count > 0) {
            array1 = (itemList?.valueForKey("itemTitle"))! as! [String]
            //print(array1)
            //print(titleText)
            if (array1.count > 0) {
                for i in 0...array1.count-1 {
                    if array1[i] == titleText {
                        //print(true)
                        saveButtom.title = "Saved"
                        saveButtom.enabled = false
                        timer.invalidate()
                    }
                }
                if array1.contains("\(titleText)") {
                    //print(true)
                    saveButtom.title = "Saved"
                    saveButtom.enabled = false
                    timer.invalidate()
                }
            }
        }
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == UIWebViewNavigationType.LinkClicked {
            if (request.URL!.host! == "example.com"){
                return true
            } else {
                let svc = SFSafariViewController(URL: request.URL!)
                svc.delegate = self
                presentViewController(svc, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while loading article. Please check internet connection.")
        timer.invalidate()
        timer2.invalidate()
        
    }
    
    private func showAlertMessage(alertTitle alertTitle: String, alertMessage: String ) -> Void {
        
        let alertCtrl = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert) as UIAlertController
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:
            { (action: UIAlertAction) -> Void in
        })
        
        alertCtrl.addAction(okAction)
        
        self.presentViewController(alertCtrl, animated: true, completion: { (void) -> Void in
        })
    }
    
    @IBOutlet var saveButtom: UIBarButtonItem!
    
    @IBAction func addItem(sender: AnyObject) {
        
        saveButtom.title = "Saved"
        saveButtom.enabled = false
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        let dataSet:NSMutableDictionary = NSMutableDictionary()
        
        let title = self.navigationItem.title!
        dataSet.setObject(title, forKey: "itemTitle")
        dataSet.setObject(webViewString, forKey: "itemURL")
        dataSet.setObject(TAN, forKey: "itemType")
        
        if ((itemList) != nil) {
            let newList:NSMutableArray = NSMutableArray()
            for dict:AnyObject in itemList!{
                newList.addObject(dict as! NSDictionary)
            }
            userDefaults.removeObjectForKey("itemList")
            newList.addObject(dataSet)
            userDefaults.setObject(newList, forKey: "itemList")
        }else{
            userDefaults.removeObjectForKey("itemList")
            itemList = NSMutableArray()
            itemList!.addObject(dataSet)
            userDefaults.setObject(itemList, forKey: "itemList")
        }
        
        userDefaults.synchronize()
        
    }
    
    @IBAction func shareEvent(sender: AnyObject) {
        
        let text = "Read \"\(titleText)\" at \(link!) "
        let shareSheet : UIActivityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        self.presentViewController(shareSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func refresh(sender: AnyObject) {
        
        if let fetchURL = NSURL(string: self.link! ) {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(fetchURL) { (data, response, error) -> Void in
                
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let titleArray = webContent?.componentsSeparatedByString("<meta property=\"og:title\" content=\"")
                    if titleArray!.count > 0 {
                        let finalTitleArray = titleArray![1].componentsSeparatedByString("\" />")
                        let titleSummary = finalTitleArray[0].stringByReplacingOccurrencesOfString("&#039;", withString: "'")
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.titleLabel.text = titleSummary
                            self.titleText = titleSummary
                            //print(finalTitleArray[0])
                        })
                    }
                    
                    let textArray = webContent?.componentsSeparatedByString("<div class=\"blog-content\">")
                    if textArray!.count > 0 {
                        let finalTextArray = textArray![1].componentsSeparatedByString("<div class=\"blog-social  \">")
                        let textSummary = finalTextArray[0].stringByReplacingOccurrencesOfString("<img src=\"", withString: "<img src=\"http://www.futureappleceo.com")
                        //print(finalTextArray[0])
                        let textSummary2 = textSummary.stringByReplacingOccurrencesOfString("font-family:'Helvetica';", withString: "")
                        //print(finalTextArray[0])
                        self.htmlString = "<font face='SF UI Display' size='3'> \(textSummary2)"
                        //print(self.htmlString)
                        
                        if self.htmlString.rangeOfString("<div><div class=\"") != nil {
                            
                            let htmlArray = self.htmlString.componentsSeparatedByString("<div><div class=\"")
                            //print(htmlArray[1])
                            self.webViewString = "<fieldset class=\"attribute-fix\" style=\"border: 2px solid black\"> <legend align=\"center\"; style=\"padding: 0 10px;\"> \(htmlArray[0]) </legend> <div><div class=\(htmlArray[1]) </fieldset>"
                            self.myWebView.loadHTMLString(self.webViewString, baseURL: nil)
                            
                        } else {
                            
                            self.webViewString = self.htmlString
                            self.myWebView.loadHTMLString(self.webViewString, baseURL: nil)
                            let alert = UIAlertController(title: "Error Loading", message: "There was an error loading the custom format for this page, I displayed it like this for you...", preferredStyle: UIAlertControllerStyle.Alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        }
                    }
                    
                }
            }
            task.resume()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("loading"), userInfo: nil, repeats: true)
        timer2 = NSTimer.scheduledTimerWithTimeInterval(9, target: self, selector: Selector("finish"), userInfo: nil, repeats: false)
        
    }
    
    @IBAction func safariVC(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: self.link!)!)
        svc.delegate = self
        presentViewController(svc, animated: true, completion: nil)
    }
    
}