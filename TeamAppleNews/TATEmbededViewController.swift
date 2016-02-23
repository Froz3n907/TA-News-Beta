//
//  TATEmbededViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 07/12/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
//

import Foundation
import UIKit
import iAd

//public updateWebView()

class TATEmbededViewController : UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var goAudio = AVPlayer()
    var show = AVAudioPlayer()
    
    var soundData : NSData!

    @IBOutlet var sliderMenu: UIBarButtonItem!
    
    var htmlString = String()
    var TAT = String()
    
    var array1 = [String]()

    @IBOutlet var buttonText: UIBarButtonItem!
    
    @IBOutlet var webView: UIWebView!
    
    var webViewString = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderMenu.target = self.revealViewController()
        sliderMenu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "updateWebView", userInfo: nil, repeats: true)
        
        webView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        webView.opaque = false
        
        TAT = "TAT"
        
        saveButtom.enabled = false
        buttonText.enabled = false
        buttonText.title = ""
        
        self.canDisplayBannerAds = true
        let removeiAds = NSUserDefaults.standardUserDefaults().objectForKey("removeiAds") as! Bool!
        if (removeiAds != nil && removeiAds == true) {
            canDisplayBannerAds = false
        }
        if (removeiAds != nil && removeiAds == false) {
            self.canDisplayBannerAds = true
        }
        
    }
    
    func updateWebView() {
        if update == true {
            
            if let fetchURL = NSURL(string: url ) {
                
                let task = NSURLSession.sharedSession().dataTaskWithURL(fetchURL) { (data, response, error) -> Void in
                    
                    if let urlContent = data {
                        
                        let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                        
                        let textArray = webContent?.componentsSeparatedByString("<div class=\"blog-content\">")
                        if textArray!.count > 0 {
                            let finalTextArray = textArray![1].componentsSeparatedByString("</div>")
                            let textSummary = finalTextArray[0].stringByReplacingOccurrencesOfString("<img src=\"", withString: "<img src=\"http://www.futureappleceo.com")
                            //print(finalTextArray[0])
                            let textSummary2 = textSummary.stringByReplacingOccurrencesOfString("font-family:'Helvetica';", withString: "")
                            //print(finalTextArray[0])
                            self.htmlString = "<font face='SF UI Display' size='3'> \(textSummary2)"
                            self.webViewString = "<fieldset class=\"attribute-fix\" style=\"border: 2px solid black\"> <legend align=\"center\"; style=\"padding: 0 10px;\"> About </legend> <div><div class=\(self.htmlString) </fieldset>"
                            self.webView.loadHTMLString(self.webViewString, baseURL: nil)
                        }
                        
                    }
                }
                task.resume()
            }
            update = false
            saveButtom.enabled = true
            saveButtom.title = "Save"
            buttonText.title = name
           
            let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            let itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
            //print(itemList)
            if (itemList?.count > 0) {
                array1 = (itemList?.valueForKey("itemTitle"))! as! [String]
                //print(array1)
                for i in 0...array1.count-1 {
                    //print(name)
                    if array1[i] == name {
                        //print(true)
                        saveButtom.title = "Saved"
                        saveButtom.enabled = false
                    }
                }
            }
            webView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.9)
            webView.opaque = false
        }
        
    }
    @IBAction func playShow(sender: UIButton) {
        self.show.prepareToPlay()
        self.show.volume = 1.0
        self.show.delegate = self
        self.show.play()
    }
    
    @IBAction func pause(sender: AnyObject) {
        audioPlayer.pause()
    }
    
    @IBAction func play(sender: AnyObject) {
        audioPlayer.play()
    }

    @IBOutlet var saveButtom: UIBarButtonItem!

    @IBAction func saveFunc(sender: AnyObject) {
        
        saveButtom.title = "Saved"
        saveButtom.enabled = false
        
        let userDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var itemList:NSMutableArray? = userDefaults.objectForKey("itemList") as? NSMutableArray
        
        let dataSet:NSMutableDictionary = NSMutableDictionary()
        
        let title = self.navigationItem.title!
        dataSet.setObject(name, forKey: "itemTitle")
        dataSet.setObject(htmlString, forKey: "itemURL")
        dataSet.setObject(TAT, forKey: "itemType")
        dataSet.setObject(selectedPodcast, forKey: "itemNumber")
        dataSet.setObject(title, forKey: "itemName")
        dataSet.setObject(audioURL, forKey: "itemAudioURL")
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  }