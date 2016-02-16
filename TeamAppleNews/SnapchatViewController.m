//
//  SnapchatViewController.m
//  TeamAppleNews
//
//  Created by Toby Woollaston on 23/07/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
//

#import "SnapchatViewController.h"
#import "SWRevealViewController.h"

@interface SnapchatViewController ()

@end

@implementation SnapchatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openSnapchat:(id)sender {
    
    NSURL *snapchatURL = [NSURL URLWithString:@"snapchat://"];
    if ([[UIApplication sharedApplication] canOpenURL:snapchatURL]) {
        [[UIApplication sharedApplication] openURL:snapchatURL];
    }
    
}

@end
