//
//  BugReporterViewController.swift
//  TA News
//
//  Created by Austin Dean on 2/22/16.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import UIKit
import WebKit


class BugReporterViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://goo.gl/forms/413QwSRlcW")!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
