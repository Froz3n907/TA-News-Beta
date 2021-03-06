//
//  TATEmbededViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 07/12/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

//public updateWebView()

class TATEmbededViewController : UIViewController {
    
    @IBOutlet var sliderMenu: UIBarButtonItem!
    
    @IBOutlet var sliderControl: UISlider!
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var pauseButton: UIButton!
    
    var htmlString = String()
    var TAT = String()
    
    var array1 = [String]()
    
    @IBOutlet var webView: UIWebView!
    
    var webViewString = String()
    
    var timeObserver: AnyObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderMenu.target = self.revealViewController()
        sliderMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(TATEmbededViewController.updateWebView), userInfo: nil, repeats: true)
        
        //webView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        //webView.opaque = false
        
        TAT = "TAT"
        
        saveButtom.enabled = false
        
        webView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.7)
        webView.opaque = false
        
        playButton.layer.cornerRadius = 36
        playButton.layer.borderWidth = 0
        playButton.layer.borderColor = UIColor.blackColor().CGColor
        
        pauseButton.layer.cornerRadius = 36
        pauseButton.layer.borderWidth = 0
        pauseButton.layer.borderColor = UIColor.blackColor().CGColor
        
        sliderControl.addTarget(self, action: #selector(TATEmbededViewController.sliderBeganTracking(_:)), forControlEvents: .TouchDown)
        sliderControl.addTarget(self, action: #selector(TATEmbededViewController.sliderEndedTracking(_:)), forControlEvents: .TouchUpInside)
        //sliderControl.addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)
        
        
        
    }
    
    var timer = NSTimer()
    
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
                sliderControl.value = 0
            }
            update = false
            saveButtom.enabled = true
            saveButtom.title = "Save"
           
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
            
            timer = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: #selector(TATEmbededViewController.updateSlider), userInfo: nil, repeats: true)
            
        }
        
    }
    
    func updateSlider() {

        let audioDuration = CMTimeGetSeconds(audioPlayer.currentItem!.duration)
        print("audioDuration = \(audioDuration)")
        let sliderWidth: Float = (1/Float(audioDuration))/10
        print("sliderWidth = \(sliderWidth)")
        let currentTime = sliderControl.value
        print("currentTime = \(currentTime)")
        sliderControl.value = currentTime + sliderWidth
        print("sliderControl.value = \(sliderControl.value)")
        
    }
    
    @IBAction func pause(sender: AnyObject) {
        audioPlayer.pause()
        timer.invalidate()
    }
    
    @IBAction func play(sender: AnyObject) {
        audioPlayer.play()
        timer = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: #selector(TATEmbededViewController.updateSlider), userInfo: nil, repeats: true)
    }
    
    var playerRateBeforeSeek: Float = 0
    
    func sliderBeganTracking(slider: UISlider!) {
        playerRateBeforeSeek = audioPlayer.rate
    }
    
    func sliderEndedTracking(slider: UISlider!) {
        let videoDuration = CMTimeGetSeconds(audioPlayer.currentItem!.duration)
        let elapsedTime: Float64 = videoDuration * Float64(sliderControl.value)
        
        audioPlayer.seekToTime(CMTimeMakeWithSeconds(elapsedTime, 10)) { (completed: Bool) -> Void in
            if (self.playerRateBeforeSeek > 0) {
                audioPlayer.play()
            }
        }
    }
    
    /*func sliderValueChanged(slider: UISlider!) {
        let videoDuration = CMTimeGetSeconds(audioPlayer.currentItem!.duration)
        let elapsedTime: Float64 = videoDuration * Float64(sliderControl.value)
    }*/
    
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