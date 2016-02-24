//
//  ToysDetailsViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 02/11/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
//

import UIKit
import SafariServices

class ToysDetailsViewController: UIViewController, UIWebViewDelegate, SFSafariViewControllerDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var myWebView: UIWebView!
    
    var link: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myWebView.delegate = self
        
        myWebView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
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
                        let htmlString = "<font face='SF UI Display' size='3'> \(textSummary2)"
                        self.myWebView.loadHTMLString(htmlString, baseURL: nil)
                    }
                    
                }
            }
            task.resume()
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
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while loading url.")
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
        dataSet.setObject(self.link!, forKey: "itemURL")
        
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
    
}
