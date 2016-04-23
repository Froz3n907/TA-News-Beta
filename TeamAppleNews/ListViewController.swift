//
//  ListViewController.swift
//  SwiftRSSReader
//
//  Created by Prashant on 14/09/15.
//  Copyright (c) 2016 PrashantKumar Mangukiya. All rights reserved.
//

import UIKit
import SVProgressHUD

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate/*, UISearchResultsUpdating, UISearchBarDelegate*/ {
    
    @IBOutlet var sliderMenu: UIBarButtonItem!
    var refreshControl: UIRefreshControl!
    
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
        self.refreshControl.addTarget(self, action: #selector(ListViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.myTableView.addSubview(refreshControl)
        
        sliderMenu.target = self.revealViewController()
        sliderMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        SVProgressHUD.showWithStatus("Loading...")
        
        //registerForPreviewingWithDelegate(self, sourceView: myTableView)
        
        parseImages = true
        
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
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            return 200
        }
        
        return 84
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rssRecordList.count
    }
    
    var task: NSURLSessionDataTask!
    var parseImages = Bool()
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.myTableView.dequeueReusableCellWithIdentifier("rssCell", forIndexPath: indexPath) as! NewsTableViewCell
        
        let thisRecord : RssRecord  = self.rssRecordList[indexPath.row]
        
        cell.articleTitle.text = thisRecord.title as String
        cell.articleDetail.text = thisRecord.pubDate as String
        
        if parseImages == true {

            if let imageLink = NSURL(string: self.rssRecordList[indexPath.row].link ) {
            
                task = NSURLSession.sharedSession().dataTaskWithURL(imageLink) { (data, response, error) -> Void in
                
                    if let urlContent = data {
                
                        let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                        let blogContent = webContent?.componentsSeparatedByString("<div class=\"blog-content\">")
                        if blogContent!.count > 0 {
                            let imageURL = blogContent![1].componentsSeparatedByString("<img src=\"")
                            let imageURL2 = imageURL[1].componentsSeparatedByString("\" alt=")
                            let finalURL = "http://www.futureappleceo.com/\(imageURL2[0])"
                            //print(finalURL)
                            dispatch_async(dispatch_get_main_queue(), {
                                cell.articleImage.contentMode = .ScaleAspectFit
                                cell.articleImage.setImageWithURL(NSURL(string: finalURL)!, placeholderImage: UIImage(named: "01.png"))
                            })
                        }
                        
                    }
            
                }
                task.resume()
            }
        }
            
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
        SVProgressHUD.dismiss()
        self.refreshControl.endRefreshing()
        parseImages = true
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        self.showAlertMessage(alertTitle: "Error", alertMessage: "Error while loading TA News. Please check internet connection.")
    }
    
    func refresh(sender:AnyObject) {
        self.loadRSSData()
        parseImages = false
    }
    
    private func loadRSSData(){
        
        if let rssURL = NSURL(string: RSS_FEED_URL1) {
            
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
            
            let destVc = segue.destinationViewController as! DetailsViewController
            
            destVc.navigationItem.title = self.rssRecordList[selectedIndexPath[0].row].title
            
            destVc.link = self.rssRecordList[selectedIndexPath[0].row].link
            
        }
        
    }
    
                /*func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = myTableView.indexPathForRowAtPoint(location) {
            //This will show the cell clearly and blur the rest of the screen for our peek.
            previewingContext.sourceRect = myTableView.rectForRowAtIndexPath(indexPath)
            return viewControllerForIndexPath(indexPath)
        }
        return nil
    }*/

}
