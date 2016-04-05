//
//  EventViewController.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 13/12/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

import UIKit
import Parse
import AVFoundation
import AVKit
import EventKit
import SVProgressHUD

class EventViewController: UIViewController {
    
    @IBOutlet var sliderMenu: UIBarButtonItem!
    
    var eventName = String()
    var eventYear = Int()
    var eventMonth = Int()
    var eventDay = Int()
    var eventHour = Int()
    var eventMinute = Int()
    var eventSecond = Int()
    
    var timer = NSTimer()
    
    var year = Int()
    var month = Int()
    var day = Int()
    var hour = Int()
    var minute = Int()
    var second = Int()
    
    var dayCalendarUnit = NSCalendarUnit()
    
    var eventDate = NSDate()
    
    var daysLeft = Int()
    var hoursLeft = Int()
    var minutesLeft = Int()
    var secondsLeft = Int()
    
    @IBOutlet var eventNameLabel: UILabel!
    @IBOutlet var eventCountdownLabel: UILabel!
    
    var offName = String()
    var date = String()
    
    @IBOutlet var offEventNameLabel: UILabel!
    @IBOutlet var eventDateLabel: UILabel!
    
    @IBOutlet var addToCalendar: UIButton!
    @IBOutlet var shareEvent: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.showWithStatus("Loading...")
        
        self.eventNameLabel.hidden = true
        self.eventCountdownLabel.hidden = true
        self.offEventNameLabel.hidden = true
        self.eventDateLabel.hidden = true
        self.addToCalendar.enabled = false
        self.shareEvent.enabled = false
        
        sliderMenu.target = self.revealViewController()
        sliderMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        
        self.eventNameLabel.text = ""
        eventCountdownLabel.text = ""
        self.offEventNameLabel.text = "Event: ..."
        self.eventDateLabel.text = "Date: ..."
        
        let eventQuery = PFQuery(className: "Events")
        eventQuery.findObjectsInBackgroundWithBlock({
            (eventArray : [PFObject]?, error: NSError?) in
            if (error == nil) {
                self.eventName = (eventArray![0].objectForKey("EventName") as? String)!
                self.eventYear = (eventArray![0].objectForKey("Year") as? Int)!
                self.eventMonth = (eventArray![0].objectForKey("Month") as? Int)!
                self.eventDay = (eventArray![0].objectForKey("Day") as? Int)!
                self.eventHour = (eventArray![0].objectForKey("Hour") as? Int)!
                self.eventMinute = 00
                self.eventSecond = 00
                
                if self.eventName == "NoEvent" {
                    self.eventNameLabel.text = "No Event Confirmed"
                    self.eventCountdownLabel.hidden = true
                    self.offEventNameLabel.hidden = true
                    self.eventDateLabel.hidden = true
                    self.addToCalendar.enabled = false
                    self.shareEvent.enabled = false
                } else {
                    self.eventNameLabel.text = self.eventName
                    self.offName = (eventArray![0].objectForKey("OffName") as? String)!
                    self.date = (eventArray![0].objectForKey("Date") as? String)!
                    self.offEventNameLabel.text = "Event: \(self.offName)"
                    self.eventDateLabel.text = "Date: \(self.date)"
                    self.eventNameLabel.hidden = false
                    self.eventCountdownLabel.hidden = false
                    self.offEventNameLabel.hidden = false
                    self.eventDateLabel.hidden = false
                    self.addToCalendar.enabled = true
                    self.shareEvent.enabled = true
                    SVProgressHUD.dismiss() 
                }
                //print(self.eventName)
                //print(self.eventYear)
                //print(self.eventMonth)
                //print(self.eventDay)
                //print(self.eventHour)
                
            } else {
                if let error = error {
                    if error.code == PFErrorCode.ErrorObjectNotFound.rawValue {
                        print("Uh oh, we couldn't find the object!")
                        // Now also check for connection errors:
                    } else if error.code == PFErrorCode.ErrorConnectionFailed.rawValue {
                        print("Uh oh, we couldn't even connect to the Parse Cloud!")
                    }
                }
            }
        })
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(EventViewController.updateCountdown), userInfo: nil, repeats: true)
        
    }
    
    func updateCountdown() {
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date)
        year = components.year
        month = components.month
        day = components.day
        hour = components.hour
        minute = components.minute
        second = components.second
        let currentDate = calendar.dateFromComponents(components)
        //print(currentDate)
        
        let userCalendar = NSCalendar.currentCalendar()
        let eventDateComponents = NSDateComponents()
        eventDateComponents.year = eventYear
        eventDateComponents.month = eventMonth
        eventDateComponents.day = eventDay
        eventDateComponents.hour = eventHour
        eventDateComponents.minute = eventMinute
        eventDateComponents.second = eventSecond
        eventDateComponents.timeZone = NSTimeZone(name: "America/Tijuana")
        eventDate = userCalendar.dateFromComponents(eventDateComponents)!
        eventDate.timeIntervalSinceDate(currentDate!)
        //print(eventDate)
        
        let difference = userCalendar.components([.Day, .Hour, .Minute, .Second], fromDate: currentDate!, toDate: eventDate, options: [])
        daysLeft = difference.day
        hoursLeft = difference.hour
        minutesLeft = difference.minute
        secondsLeft = difference.second
        eventCountdownLabel.text = "\(daysLeft)d \(hoursLeft)h \(minutesLeft)m \(secondsLeft)s"
    }

    func createEvent(eventStore: EKEventStore, title: String, startDate: NSDate, endDate: NSDate) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.saveEvent(event, span: .ThisEvent)
            let alert = UIAlertController(title: self.eventName, message: "The event \"\(self.eventName)\" was successfully added to your calendar!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } catch {
            print("Bad things happened")
            let alert = UIAlertController(title: "Error", message: "The event \(self.eventName) failed to add to your calendar!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func addToCalendar(sender: AnyObject) {
        
        let eventStore = EKEventStore()
        
        let startDate = eventDate
        
        let endDate = startDate.dateByAddingTimeInterval(60 * 60 * 2)
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: {
                granted, error in
                self.createEvent(eventStore, title: self.eventName, startDate: startDate, endDate: endDate)
            })
        } else {
            createEvent(eventStore, title: self.eventName, startDate: startDate, endDate: endDate)
        }
        
    }
    
    @IBAction func shareEvent(sender: AnyObject) {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.FullStyle
        formatter.timeStyle = .ShortStyle
        let dateString = formatter.stringFromDate(eventDate)
        let text = "\(eventName) will be on \(dateString). Follow FutureAppleCEO's coverage at http://goo.gl/qQPs5D"
        let shareSheet : UIActivityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        self.presentViewController(shareSheet, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
