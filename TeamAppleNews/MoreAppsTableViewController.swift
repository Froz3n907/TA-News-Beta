//
//  MoreAppsTableViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 22/12/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
//

import UIKit

class MoreAppsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "emerald.png"))
        
        self.canDisplayBannerAds = true
        let removeiAds = NSUserDefaults.standardUserDefaults().objectForKey("removeiAds") as! Bool!
        if (removeiAds != nil && removeiAds == true) {
            canDisplayBannerAds = false
        }
        if (removeiAds != nil && removeiAds == false) {
            self.canDisplayBannerAds = true
        }
        
        tableView.tableFooterView = UIView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdentifier: String
        
        switch indexPath.row {
        case 0:
            cellIdentifier = "fj"
        case 1:
            cellIdentifier = "pong"
        default:
            cellIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        return cell
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    @IBAction func downloadFJ(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "itmss://itunes.apple.com/us/app/flappy-jackie/id829782203?mt=8ign-msr=https%3A%2F%2Fitunesconnect.apple.com%2FWebObjects%2FiTunesConnect.woa%2Fra%2Fng%2Fapp%2F829782203")!)
    }
    
    @IBAction func downloadPong(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "itmss://itunes.apple.com/us/app/pong/id827756643?ls=1mt=8ign-msr=https%3A%2F%2Fitunesconnect.apple.com%2FWebObjects%2FiTunesConnect.woa%2Fra%2Fng%2Fapp%2F827756643")!)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
