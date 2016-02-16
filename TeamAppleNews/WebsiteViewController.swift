//
//  WebsiteViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 02/12/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
//

import UIKit
import SafariServices

class WebsiteViewController: UIViewController, SFSafariViewControllerDelegate {

    @IBOutlet var sliderMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let svc = SFSafariViewController(URL: NSURL(string: "http://www.futureappleceo.com/")!)
        svc.delegate = self
        presentViewController(svc, animated: true, completion: nil)
        
        sliderMenu.target = self.revealViewController()
        sliderMenu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Do any additional setup after loading the view.
    }
    
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        NSTimer.scheduledTimerWithTimeInterval(0, target: self.revealViewController(), selector: ("revealToggle:"), userInfo: nil, repeats: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openWeb(sender: AnyObject) {
        let svc = SFSafariViewController(URL: NSURL(string: "http://www.futureappleceo.com/")!)
        svc.delegate = self
        presentViewController(svc, animated: true, completion: nil)
    }

}
