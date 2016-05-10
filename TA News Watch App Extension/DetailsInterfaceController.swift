//
//  DetailsInterfaceController.swift
//  TA News
//
//  Created by Toby Woollaston on 10/05/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import WatchKit
import Foundation

var articleTitle = String()
var articleDescription = String()
var articleImage = String()

class DetailsInterfaceController: WKInterfaceController {

    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var textLabel: WKInterfaceLabel!
    @IBOutlet var titleGroup: WKInterfaceGroup!
    
    @IBAction func saveToBookmarks() {
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let image1 = articleImage.componentsSeparatedByString("<a> <img src=\"")
        let image2 = image1[1].componentsSeparatedByString("\"")
        let image3 = NSURL(string: image2[0])
        let task = NSURLSession.sharedSession().dataTaskWithURL(image3!, completionHandler: {
            (data, response, error) -> Void in
            
            self.titleGroup.setBackgroundImageData(data)
            
        })
        task.resume()
        
        titleLabel.setText(articleTitle)
        //print(articleTitle)
        let text = articleDescription.stringByReplacingOccurrencesOfString("&#8203;", withString: " ")
        let text1 = text.stringByReplacingOccurrencesOfString("&nbsp;", withString: " ")
        let text2 = text1.stringByReplacingOccurrencesOfString("[...]", withString: "")
        let text3 = text2.stringByReplacingOccurrencesOfString("&lsquo;", withString: "")
        let text4 = text3.stringByReplacingOccurrencesOfString("&rsquo;", withString: "")
        let finalText = "\(text4)... Read more on the iPhone App..."
        textLabel.setText(finalText)
        //print(articleDescription)
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
