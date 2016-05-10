//
//  TANewsFeedInterfaceController.swift
//  TA News
//
//  Created by Toby Woollaston on 10/05/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import WatchKit
import Foundation


class TANewsFeedInterfaceController: WKInterfaceController, NSXMLParserDelegate {
    
    @IBOutlet var table: WKInterfaceTable!
    var titles = [String]()
    var descriptions = [String]()
    var images = [String]()
    var element = ""
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let url = NSURL(string: "http://www.futureappleceo.com/2/feed?min-results=250")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
            (data, response, error) -> Void in
            
            if error == nil {
                
                //let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                //print(urlContent)
                
                var xmlParser = NSXMLParser()
                xmlParser = NSXMLParser(data: data!)
                xmlParser.delegate = self
                xmlParser.parse()
                
                self.table.setNumberOfRows(self.titles.count, withRowType: "TableViewCell")
                
                for (index, title) in self.titles.enumerate() {
                    let row = self.table.rowControllerAtIndex(index) as! TANewsCellI
                    row.rowLabel.setText(title)
                }
                
            }
            
        })
        
        task.resume()
        
        // Configure interface objects here.
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element = elementName
        //print(elementName)
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if element == "title" && string != "FutureAppleCEO - TeamApple News"{
            titles.append(string)
            //print(string)
        }
        
        if element == "description" {
            descriptions.append(string)
            //print(string)
        }
        
        if element == "content:encoded" {
            images.append(string)
            //print(string)
        }
        
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        //print(titles[rowIndex])
        //print(descriptions[rowIndex + 1])
        //print(images[rowIndex])
        articleTitle = titles[rowIndex]
        articleDescription = descriptions[rowIndex + 1]
        articleImage = images[rowIndex]
        pushControllerWithName("detail", context: "fromTANews")
        
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
