//
//  AppConnectViewController.m
//  TeamAppleNews
//
//  Created by Toby Woollaston on 05/12/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

#import "AppConnectViewController.h"
#import "SWRevealViewController.h"

@interface AppConnectViewController ()

@end

@implementation AppConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Slider Menu
    _sliderMenu.target = self.revealViewController;
    _sliderMenu.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)facebook:(id)sender {
    
    NSURL *facebookURL = [NSURL URLWithString:@"fb://profile/812689255420459"];
    if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
        [[UIApplication sharedApplication] openURL:facebookURL];
    } else {
        SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.facebook.com/Futureappleceoofficial?fref=ts"]];
        svc.delegate = self;
        [self presentViewController:svc animated:YES completion:nil];
    }
    
}

- (IBAction)twitter:(id)sender {
    
    NSURL *twitterURL = [NSURL URLWithString:@"twitter://user?screen_name=futureappleceo1"];
    if ([[UIApplication sharedApplication] canOpenURL:twitterURL]) {
        [[UIApplication sharedApplication] openURL:twitterURL];
    } else {
        SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://twitter.com/futureappleceo1"]];
        svc.delegate = self;
        [self presentViewController:svc animated:YES completion:nil];
    }
    
}

- (IBAction)snapchat:(id)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"futureappleceo1";
    
}

- (IBAction)youtube:(id)sender {
    
    NSString* youtubeURL   = @"https://www.youtube.com/c/FutureAppleCEOOfficial";
    NSString* youtubeApp = @"youtube://www.youtube.com/channel/UCNhWGzEhb0qdd7XiFn9FFxw";
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:youtubeApp]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:youtubeApp]];
    } else {
        SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:youtubeURL]];
        svc.delegate = self;
        [self presentViewController:svc animated:YES completion:nil];
    }
    
}

- (IBAction)reddit:(id)sender {
    
    SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.reddit.com/r/FutureAppleCEO/"]];
    svc.delegate = self;
    [self presentViewController:svc animated:YES completion:nil];
    
}

- (IBAction)tumblr:(id)sender {
    
    NSURL *tumblrURL = [NSURL URLWithString:@"tumblr://x-callback-url/blog?blogName=futureappleceo"];
    if ([[UIApplication sharedApplication] canOpenURL:tumblrURL]) {
        [[UIApplication sharedApplication] openURL:tumblrURL];
    } else {
        SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.futureappleceo.tumblr.com"]];
        svc.delegate = self;
        [self presentViewController:svc animated:YES completion:nil];
    }
    
}

@end
