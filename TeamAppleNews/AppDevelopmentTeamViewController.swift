//
//  AppDevelopmentTeamViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 22/12/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import UIKit
import SafariServices

class AppDevelopmentTeamViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet var sliderMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func michael(sender: AnyObject) {
        let instagramHooks = "instagram://user?username=michael.conte"
        let instagramUrl = NSURL(string: instagramHooks)
        UIApplication.sharedApplication().openURL(instagramUrl!)
    }
    
    @IBAction func toby(sender: AnyObject) {
        let instagramHooks = "instagram://user?username=tobywoollaston"
        let instagramUrl = NSURL(string: instagramHooks)
        UIApplication.sharedApplication().openURL(instagramUrl!)
    }
    
    @IBAction func brychan(sender: AnyObject) {
        let instagramHooks = "instagram://user?username=brychh"
        let instagramUrl = NSURL(string: instagramHooks)
        UIApplication.sharedApplication().openURL(instagramUrl!)
    }
    
    @IBAction func josh(sender: AnyObject) {
        let instagramHooks = "instagram://user?username=jhowe1997"
        let instagramUrl = NSURL(string: instagramHooks)
        UIApplication.sharedApplication().openURL(instagramUrl!)
    }
    
    @IBAction func austin(sender: AnyObject) {
        let instagramHooks = "instagram://user?username=froz3n907_futureappleceo"
        let instagramUrl = NSURL(string: instagramHooks)
        UIApplication.sharedApplication().openURL(instagramUrl!)
    }
    
    @IBAction func joel(sender: AnyObject) {
        let instagramHooks = "instagram://user?username=gatortech94"
        let instagramUrl = NSURL(string: instagramHooks)
        UIApplication.sharedApplication().openURL(instagramUrl!)
    }
    
    @IBAction func fullTeam(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: "http://www.futureappleceo.com/team.html")!)
        svc.delegate = self
        presentViewController(svc, animated: true, completion: nil)
    }
}
