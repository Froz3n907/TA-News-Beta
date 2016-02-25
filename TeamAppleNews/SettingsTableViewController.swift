//
//  SettingsTableViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 21/12/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import UIKit

class SettingsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var sliderMenu: UIBarButtonItem!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.backgroundView = UIImageView(image: UIImage(named: "emerald.png"))
        
        sliderMenu.target = self.revealViewController()
        sliderMenu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        tableView.tableFooterView = UIView()
        
        tableView.separatorStyle = .None
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellIdentifier: String
        
        switch indexPath.row {
        case 0:
            cellIdentifier = "plain"
        /*case 1:
            cellIdentifier = "remove"*/
        case 1:
            cellIdentifier = "team"
        case 2:
            cellIdentifier = "rate"
        /*case 4:
            cellIdentifier = "restore"*/
        case 3:
            cellIdentifier = "not"
        case 4:
            cellIdentifier = "pic"
        case 5:
            cellIdentifier = "ver"
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
        return 6
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        }
        if indexPath.row == 4 {
            return 156
        }
        if indexPath.row == 5 {
            return 22
        }
        return 55
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("plain", forIndexPath: indexPath)
            cell.selectionStyle = .None
        }
        /*if indexPath.row == 1 {
            InAppPurchase.sharedInstance.removeAdBanner()
        }*/
        if indexPath.row == 2 {
            UIApplication.sharedApplication().openURL(NSURL(string: "https://itunes.apple.com/us/app/teamapplenews/id995706775?ls=1&mt=8")!)
        }
        /*if indexPath.row == 4 {
            InAppPurchase.sharedInstance.restoreTransactions()
        }*/
        if indexPath.row == 3 {
            if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(appSettings)
            }
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("pic", forIndexPath: indexPath)
            cell.selectionStyle = .None
        }
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCellWithIdentifier("pic", forIndexPath: indexPath)
            cell.selectionStyle = .None
        }
        
    }
    
}
