//
//  SettingsTableViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 21/12/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import UIKit
import SVProgressHUD

class SettingsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var sliderMenu: UIBarButtonItem!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.backgroundView = UIImageView(image: UIImage(named: "emerald.png"))
        
        sliderMenu.target = self.revealViewController()
        sliderMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
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
        //case 5:
        //    cellIdentifier = "ver"
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
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        }
        if indexPath.row == 4 {
            return 156
        }
        //if indexPath.row == 5 {
        //    return 22
        //}
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
            SVProgressHUD.show()
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Gradient)
            UIApplication.sharedApplication().openURL(NSURL(string: "https://itunes.apple.com/us/app/ta-news/id995706775?ls=1&mt=8")!)
            SVProgressHUD.dismiss()
        }
        /*if indexPath.row == 4 {
            InAppPurchase.sharedInstance.restoreTransactions()
        }*/
        if indexPath.row == 3 {
            SVProgressHUD.show()
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Gradient)
            if let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(appSettings)
            }
            SVProgressHUD.dismiss()
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCellWithIdentifier("pic", forIndexPath: indexPath)
            cell.selectionStyle = .None
        }
        //if indexPath.row == 5 {
        //    let cell = tableView.dequeueReusableCellWithIdentifier("pic", forIndexPath: indexPath)
        //    cell.selectionStyle = .None
        //}
        
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        
        let nsObject: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
        let versionNumber = nsObject as! String
        print(versionNumber)
        let buildObject: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"]
        let build = buildObject as! String
        print(build)
        print("v\(versionNumber) Build \(build)")
        
        let version = UILabel(frame: CGRectMake(8, 15, tableView.frame.width, 30))
        version.font = version.font.fontWithSize(12)
        version.text = "v\(versionNumber) Build \(build)"
        version.textColor = UIColor.darkGrayColor()
        version.textAlignment = .Center;
        
        view.addSubview(version)

        return view
    }
    
}
