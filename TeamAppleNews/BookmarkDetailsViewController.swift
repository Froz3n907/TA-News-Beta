//
//  BookmarkDetailsViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 02/11/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import UIKit
import SafariServices
import Parse
import AVFoundation
import AVKit

class BookmarkDetailsViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet var bottomBar: UIToolbar!
    
    @IBOutlet var buttonText: UIBarButtonItem!
    
    var IDArray = [String]()
    var nameArray = [String]()
    var urlArray = [String]()
    
    var timer = NSTimer()
    
    @IBOutlet var titleLabel: UILabel!
    
    var toDoData:NSDictionary = NSDictionary()
    
    @IBOutlet var bWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bottomBar.hidden = true
        
        self.navigationItem.title = toDoData.objectForKey("itemTitle") as? String
        
        bWebView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        bWebView.opaque = false
        
        self.titleLabel.text = toDoData.objectForKey("itemTitle") as? String
        
        let htmlString = toDoData.objectForKey("itemURL") as? String
        
        self.bWebView.loadHTMLString(htmlString!, baseURL: nil)
        
        let type = (toDoData.objectForKey("itemType"))! as? String
        //print(type)
        if type == "TAT" {
            self.titleLabel.text = toDoData.objectForKey("itemName") as? String
            
            let audioUrl = toDoData.objectForKey("itemAudioURL")
                
            if let audioFileURLTemp = audioUrl {
                    
                audioPlayer = AVPlayer(URL: NSURL(string: audioFileURLTemp as! String)!)
                timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("playAudio"), userInfo: nil, repeats: false)
                    
                self.bottomBar.hidden = false
                buttonText.enabled = false
                buttonText.title = toDoData.objectForKey("itemTitle") as? String
                    
            }
           
        }
        if type == "TAN" {
            bWebView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
            bWebView.opaque = false
            self.titleLabel.backgroundColor = UIColor.whiteColor()
        }
        
    }
    
    func playAudio() {
        audioPlayer.play()
    }
    
    @IBAction func pause(sender: AnyObject) {
        audioPlayer.pause()
    }
    
    @IBAction func play(sender: AnyObject) {
        audioPlayer.play()
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
        // Dispose of any resources that can be recreated.
    }

    @IBAction func deleteNote(sender: AnyObject) {
    
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
        let itemListArray:NSMutableArray = userDefaults.objectForKey("itemList") as! NSMutableArray
    
        let mutableItem:NSMutableArray = NSMutableArray()
    
        for dict:AnyObject in itemListArray {
            mutableItem.addObject(dict as! NSDictionary)
        }
    
        mutableItem.removeObject(toDoData)
    
        userDefaults.removeObjectForKey("itemList")
        userDefaults.setObject(mutableItem, forKey: "itemList")
    
        self.navigationController?.popToRootViewControllerAnimated(true)
    
    }

}
