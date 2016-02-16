//
//  SettingsTableViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 21/12/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
//

import UIKit
import iAd

class SettingsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var sliderMenu: UIBarButtonItem!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.backgroundView = UIImageView(image: UIImage(named: "emerald.png"))
        
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
        
        tableView.tableFooterView = UIView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdentifier: String
        
        switch indexPath.row {
        case 0:
            cellIdentifier = "plain"
        case 1:
            cellIdentifier = "remove"
        case 2:
            cellIdentifier = "team"
        case 3:
            cellIdentifier = "rate"
        case 4:
            cellIdentifier = "restore"
        case 5:
            cellIdentifier = "not"
        case 6:
            cellIdentifier = "pic"
        default:
            cellIdentifier = "Cell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        }
        if indexPath.row == 6 {
            return 156
        }
        return 55
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("plain", forIndexPath: indexPath)
            cell.selectionStyle = .None
        }
        if indexPath.row == 1 {
            InAppPurchase.sharedInstance.removeAdBanner()
        }
        if indexPath.row == 3 {
            UIApplication.sharedApplication().openURL(NSURL(string: "https://itunes.apple.com/us/app/teamapplenews/id995706775?ls=1&mt=8")!)
        }
        if indexPath.row == 4 {
            InAppPurchase.sharedInstance.restoreTransactions()
        }
        if indexPath.row == 5 {
            if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(appSettings)
            }
        }
        if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCellWithIdentifier("pic", forIndexPath: indexPath)
            cell.selectionStyle = .None
        }
        
    }
    
}
