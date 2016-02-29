//
//  InstagramViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 30/12/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import UIKit
import Parse
import AVFoundation
import AVKit
import SVProgressHUD

class InstagramViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var accountsTable: UITableView!
    
    var nameArray = [String]()
    var usernameArray = [String]()
    var pictureArray = [PFFile]()
    
    var accounts: NSMutableArray! = NSMutableArray()
    var username: NSMutableArray! = NSMutableArray()
    var pictures: NSMutableArray! = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountsTable.tableFooterView = UIView()
        
        SVProgressHUD.showWithStatus("Loading...")

        let objectIDQuery = PFQuery(className: "InstagramAccounts")
        objectIDQuery.findObjectsInBackgroundWithBlock({
            (objectsArray : [PFObject]?, error: NSError?) in
            if(error == nil) {
                for i in 0...objectsArray!.count-1 {
                    self.nameArray.append(objectsArray![i].valueForKey("AccountName") as! String)
                    self.usernameArray.append(objectsArray![i].valueForKey("AccountUsername") as! String)
                    self.pictureArray.append(objectsArray![i].valueForKey("ProfilePic") as! PFFile)
                    //print(self.nameArray)
                    //print(self.usernameArray)
                    //print(self.pictureArray)
                    self.accountsTable.reloadData()
                    SVProgressHUD.dismiss()
                }
            }
        })
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.accountsTable.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! InstagramTableViewCell
        
        accounts = NSMutableArray(array: nameArray)
        cell.accountLabel.text = accounts.objectAtIndex(indexPath.row) as? String
        
        cell.viewAccount.tag = indexPath.row
        cell.viewAccount.addTarget(self, action: "viewAccount:", forControlEvents: .TouchUpInside)
        
        username = NSMutableArray(array: usernameArray)
        
        pictures = NSMutableArray(array: pictureArray)
        //let imageFile = pictures.objectAtIndex(indexPath.row) as! PFFile
        let imageFile:PFFile = pictures[indexPath.row] as! PFFile
        imageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?)-> Void in
            if (error == nil) {
                let image = UIImage(data: imageData!)
                cell.accountImage.image = image
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }

    @IBAction func viewAccount(sender: UIButton) {
        
        let urlString = self.username.objectAtIndex(sender.tag) as! String
        //print(urlString)
        let instagramHooks = "instagram://user?username=\(urlString)"
        //print(instagramHooks)
        let instagramUrl = NSURL(string: instagramHooks)
        UIApplication.sharedApplication().openURL(instagramUrl!)
        
    }
    
}
