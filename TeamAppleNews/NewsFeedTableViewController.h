//
//  NewsFeedTableViewController.h
//  TeamAppleNews
//
//  Created by Toby Woollaston on 18/07/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface NewsFeedTableViewController : UITableViewController <NSXMLParserDelegate, ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sliderMenu;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
