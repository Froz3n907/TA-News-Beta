//
//  AppDelegate.swift
//  TeamAppleNews
//
//  Created by Toby Woollaston on 31/10/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//
/*
<key>UIApplicationShortcutItems</key>
<array>
<dict>
<key>UIApplicationShortcutItemTitle</key>
<string>TeamApple News</string>
<key>UIApplicationShortcutItemType</key>
<string>TAN</string>
<key>UIApplicationShortcuteItemIconFile</key>
<string>tan black.PNG</string>
</dict>
<dict>
<key>UIApplicationShortcutItemTitle</key>
<string>TeamApple Talk</string>
<key>UIApplicationShortcutItemType</key>
<string>TAT</string>
<key>UIApplicationShortcuteItemIconFile</key>
<string>tat black.PNG</string>
</dict>
<dict>
<key>UIApplicationShortcutItemTitle</key>
<string>TeamApple Toys</string>
<key>UIApplicationShortcutItemType</key>
<string>toys</string>
<key>UIApplicationShortcuteItemIconFile</key>
<string>toys black.PNG</string>
</dict>
<dict>
<key>UIApplicationShortcutItemTitle</key>
<string>Bookmarks</string>
<key>UIApplicationShortcutItemType</key>
<string>book</string>
<key>UIApplicationShortcuteItemIconFile</key>
<string>books black.PNG</string>
</dict>
<dict>
<key>UIApplicationShortcutItemTitle</key>
<string>Events</string>
<key>UIApplicationShortcutItemType</key>
<string>event</string>
<key>UIApplicationShortcuteItemIconFile</key>
<string>events black.PNG</string>
</dict>
</array>
*/

import UIKit
import Parse
import Bolts
import Fabric
import Crashlytics
import DigitsKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Instabug.startWithToken("affae67b70d67a9976da331bf9d04d7f", invocationEvent: IBGInvocationEventFloatingButton)
        Parse.enableLocalDatastore()
        Parse.setApplicationId("1HJPhBvsiNk0SHvAW9PhIKr88xqpO5LK0TcgKkgm",
            clientKey: "K8rEAlEcyufROFiraAGEHesKuf6KFpGBzhuzVFSB")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        Fabric.with([Crashlytics.self])
        if application.applicationState != UIApplicationState.Background {            
            let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
            let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
            var pushPayload = false
            if let options = launchOptions {
                pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
            }
            if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
                PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
            }
        }
        if application.respondsToSelector("registerUserNotificationSettings:") {
            let userNotificationTypes = UIUserNotificationType.Alert; UIUserNotificationType.Badge; UIUserNotificationType.Sound
            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        
        [[UIApplication.sharedApplication().applicationIconBadgeNumber=0]];
        [[UIApplication.sharedApplication().cancelAllLocalNotifications()]];
        
        //if let shortcutItems = application.shortcutItems where shortcutItems.isEmpty {
            //let dynamicShortcut = UIMutableApplicationShortcutItem
        //}
        
        Fabric.with([Crashlytics.self])

        return true
        
        
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
        self.window?.rootViewController?.dismissViewControllerAnimated(false, completion: nil)
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        if error.code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        PFPush.handlePush(userInfo)
        if application.applicationState == UIApplicationState.Inactive {
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
            
            [[UIApplication.sharedApplication().applicationIconBadgeNumber=1]];
            [[UIApplication.sharedApplication().applicationIconBadgeNumber=0]];
            [[UIApplication.sharedApplication().cancelAllLocalNotifications()]]
                        
        }
    }

    /*func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        
        if shortcutItem.type == "TAN" {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let newVC = sb.instantiateViewControllerWithIdentifier("TAN") as! ListViewController
            let root = UIApplication.sharedApplication().keyWindow?.rootViewController
            root?.presentViewController(newVC, animated: false, completion: { () -> Void in
                completionHandler(true)
            })
        }
        if shortcutItem.type == "TAT" {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let newVC = sb.instantiateViewControllerWithIdentifier("TAT") as! TATEmbededViewController
            let root = UIApplication.sharedApplication().keyWindow?.rootViewController
            root?.presentViewController(newVC, animated: false, completion: { () -> Void in
                completionHandler(true)
            })
        }
        if shortcutItem.type == "toys" {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let newVC = sb.instantiateViewControllerWithIdentifier("TOYS") as! ToysTableViewController
            let root = UIApplication.sharedApplication().keyWindow?.rootViewController
            root?.presentViewController(newVC, animated: false, completion: { () -> Void in
                completionHandler(true)
            })
        }
        if shortcutItem.type == "book" {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let newVC = sb.instantiateViewControllerWithIdentifier("BOOK") as! BookmarksTableViewController
            let root = UIApplication.sharedApplication().keyWindow?.rootViewController
            root?.presentViewController(newVC, animated: false, completion: { () -> Void in
                completionHandler(true)
            })
        }
        if shortcutItem.type == "event" {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let frontNavigationController = storyboard.instantiateViewControllerWithIdentifier("planningViewController")
            let rearNavifationController = storyboard.instantiateViewControllerWithIdentifier("menuViewController")
            let mainRevealController : SWRevealViewController = SWRevealViewController(rearViewController: rearNavifationController, frontViewController: frontNavigationController)
            self.window?.rootViewController? = mainRevealController
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let newVC = sb.instantiateViewControllerWithIdentifier("EVENT") as! EventViewController
            let root = UIApplication.sharedApplication().keyWindow?.rootViewController
            root?.presentViewController(newVC, animated: false, completion: { () -> Void in
                completionHandler(true)
            })
        }
        
    }*/

}

