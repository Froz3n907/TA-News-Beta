//
//  ToysTableViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 02/11/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
//

import UIKit
import iAd

class ToysTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate {
    
    @IBOutlet var sliderMenu: UIBarButtonItem!
    var refreshControl:UIRefreshControl!
    
    @IBOutlet var myTableView: UITableView!
    
    var myParser: NSXMLParser = NSXMLParser()
    
    var rssRecordList : [RssRecord] = [RssRecord]()
    var rssRecord : RssRecord?
    var isTagFound = [ "item": false , "title":false, "pubDate": false ,"link":false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.myTableView.addSubview(refreshControl)
        
        sliderMenu.target = self.revealViewController()
        sliderMenu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.canDisplayBannerAds = true
        let removeiAds = NSUserDefaults.standardUserDefaults().objectForKey("removeiAds") as! Bool!
        if (removeiAds != nil && removeiAds == true) {
            canDisplayBannerAds = false
        }
        if (removeiAds != nil && removeiAds == false) {
            self.canDisplayBannerAds = true
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if self.rssRecordList.isEmpty {
            self.loadRSSData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rssRecordList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("rssCell", forIndexPath: indexPath)
        
        let thisRecord : RssRecord  = self.rssRecordList[indexPath.row]
        
        cell.textLabel?.text = thisRecord.title
        cell.detailTextLabel?.text = thisRecord.pubDate
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("segueShowDetails", sender: self)
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "item" {
            self.isTagFound["item"] = true
            self.rssRecord = RssRecord()
            
        }else if elementName == "title" {
            self.isTagFound["title"] = true
            
        }else if elementName == "link" {
            self.isTagFound["link"] = true
            
        }else if elementName == "pubDate" {
            self.isTagFound["pubDate"] = true
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if isTagFound["title"] == true {
            self.rssRecord?.title += string
            
        }else if isTagFound["link"] == true {
            self.rssRecord?.link += string
            
        }else if isTagFound["pubDate"] == true {
            self.rssRecord?.pubDate += string
        }
        
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            self.isTagFound["item"] = false
            self.rssRecordList.append(self.rssRecord!)
            
        }else if elementName == "title" {
            self.isTagFound["title"] = false
            
        }else if elementName == "link" {
            self.isTagFound["link"] = false
            
        }else if elementName == "pubDate" {
            self.isTagFound["pubDate"] = false
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
        self.myTableView.reloadData()
        
        if rssRecordList.count == 0 {
        } else {
            myTableView.tableFooterView = UIView()
        }
        
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while parsing xml.")
    }
    
    func refresh(sender:AnyObject) {
        self.myTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    private func loadRSSData(){
        
        if let rssURL = NSURL(string: RSS_FEED_URL3) {
            
            self.myParser = NSXMLParser(contentsOfURL: rssURL)!
            
            self.myParser.delegate = self
            self.myParser.shouldResolveExternalEntities = false
            
            self.myParser.parse()
            
        }
        
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueShowDetails" {
            
            let selectedIndexPath : [NSIndexPath] = self.myTableView.indexPathsForSelectedRows!
            
            self.myTableView.deselectRowAtIndexPath(selectedIndexPath[0], animated: true)
            
            let destVc = segue.destinationViewController as! ToysDetailsViewController
            
            destVc.navigationItem.title = self.rssRecordList[selectedIndexPath[0].row].title
            
            destVc.link = self.rssRecordList[selectedIndexPath[0].row].link
            
        }
        
    }
    
}
