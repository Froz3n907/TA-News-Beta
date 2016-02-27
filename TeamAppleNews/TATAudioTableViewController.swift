//
//  TATAudioTableViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 06/12/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import UIKit
import Parse
import AVFoundation
import AVKit
import AVFoundation

public var audioPlayer = AVPlayer()
public var selectedPodcast = Int()
public var update = Bool()
public var url = String()
public var name = String()
public var audioURL = String()

class TATAudioTableViewController: UITableViewController, AVAudioPlayerDelegate {
    
    @IBOutlet var sliderMenu: UIBarButtonItem!

    var IDArray = [String]()
    var nameArray = [String]()
    var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let objectIDQuery = PFQuery(className: "Audio")
        objectIDQuery.findObjectsInBackgroundWithBlock({
            (objectsArray : [PFObject]?, error: NSError?) in
            if(error == nil) {
                for i in 0...objectsArray!.count-1 {
                    self.IDArray.append(objectsArray![i].valueForKey("objectId") as! String)
                    self.nameArray.append(objectsArray![i].valueForKey("AudioName") as! String)
                    self.urlArray.append(objectsArray![i].valueForKey("WebsiteLink") as! String)
                    self.tableView.reloadData()
                    //NSLog("Array is : \(objectsArray)")
                    //print(self.nameArray)
                    //print(self.urlArray)
                }
            }
        })
        
        update = false
        
    }
        
    func grabAudio() {
        
        let audioQuery = PFQuery(className: "Audio")
        audioQuery.getObjectInBackgroundWithId(IDArray[selectedPodcast], block: {
            
            (object : PFObject?, error : NSError?) -> Void in
            if let audioFileURLTemp = object?.objectForKey("AudioFile")?.url as String! {
                
                audioURL = audioFileURLTemp
                
                audioPlayer = AVPlayer(URL: NSURL(string: audioFileURLTemp)!)
                audioPlayer.play()
                
            }
            
        })
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell!
        
        cell.textLabel?.text = nameArray[indexPath.row]
                
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedPodcast = indexPath.row
        grabAudio()
        name = nameArray[indexPath.row]
        
        url = urlArray[indexPath.row]
        update = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IDArray.count
    }

}
