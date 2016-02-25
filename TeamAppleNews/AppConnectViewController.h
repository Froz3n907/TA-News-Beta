//
//  AppConnectViewController.h
//  TeamAppleNews
//
//  Created by Toby Woollaston on 05/12/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>

@interface AppConnectViewController : UIViewController <SFSafariViewControllerDelegate> {
    
    IBOutlet UILabel *text;
    IBOutlet UIImageView *background;
    IBOutlet UIButton *twitter;
    IBOutlet UIButton *tumblr;
    IBOutlet UIButton *facebook;
    IBOutlet UIButton *snapchat;
    IBOutlet UIButton *youtube;
    IBOutlet UIButton *instagram;
    IBOutlet UIButton *reddit;
    
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sliderMenu;

-(IBAction)twitter:(id)sender;
-(IBAction)tumblr:(id)sender;
-(IBAction)facebook:(id)sender;
-(IBAction)snapchat:(id)sender;
-(IBAction)youtube:(id)sender;
-(IBAction)reddit:(id)sender;

@end
