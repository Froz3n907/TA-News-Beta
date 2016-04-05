//
//  BookmarksTableViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 01/11/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import UIKit

class BookmarksTableViewController: UITableViewController {

    @IBOutlet var sliderMenu: UIBarButtonItem!
    
    var toDoItems:NSMutableArray = NSMutableArray()

    override func viewDidAppear(animated: Bool) {
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let itemListFromData:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        if ((itemListFromData) != nil){
            toDoItems = itemListFromData!
        }
        self.tableView.reloadData()
        if itemListFromData?.count == 0 {
            self.navigationItem.title = "No Bookmarks Saved!"
        } else {
            tableView.tableFooterView = UIView()
            self.navigationItem.title = "Bookmarks"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "emerald.png"))
        
        sliderMenu.target = self.revealViewController()
        sliderMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let itemListFromData:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        if ((itemListFromData) != nil){
            toDoItems = itemListFromData!
        }
        self.tableView.reloadData()
        if itemListFromData?.count == 0 {
            self.navigationItem.title = "No Bookmarks Saved!"
        } else {
            tableView.tableFooterView = UIView()
            self.navigationItem.title = "Bookmarks"
        }
                
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let toDoItem:NSDictionary = toDoItems.objectAtIndex(indexPath.row) as! NSDictionary
        cell.textLabel!.text = toDoItem.objectForKey("itemTitle") as? String
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "detail") {
            let selectedRow:NSIndexPath = self.tableView.indexPathForSelectedRow!
            let detailView:BookmarkDetailsViewController = segue.destinationViewController as! BookmarkDetailsViewController
            detailView.toDoData = toDoItems.objectAtIndex(selectedRow.row) as! NSDictionary
        }
    }

}
