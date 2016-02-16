//
//  AppConnectViewController.m
//  TeamAppleNews
//
//  Created by Toby Woollaston on 05/12/2015.
//  Copyright © 2015 FutureAppleCEO. All rights reserved.
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
    
    [text setAlpha:0];
    [twitter setAlpha:0];
    [tumblr setAlpha:0];
    [facebook setAlpha:0];
    [snapchat setAlpha:0];
    [youtube setAlpha:0];
    [instagram setAlpha:0];
    [reddit setAlpha:0];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelay:1];
    [UIView setAnimationDuration:0.5];
    [text setAlpha:1];
    [twitter setAlpha:.85];
    [tumblr setAlpha:.85];
    [facebook setAlpha:.85];
    [snapchat setAlpha:.85];
    [youtube setAlpha:.85];
    [instagram setAlpha:.85];
    [reddit setAlpha:.85];
    [UIView commitAnimations];

}

- (void)viewDidAppear:(BOOL)animated {
    
    //iphone size
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if( screenHeight < screenWidth ){
        screenHeight = screenWidth;
    }
    
    [self.view removeConstraints:self.view.constraints];
    
    [self->text removeConstraints:self->text.constraints];
    self->text.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self->text.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self->background removeConstraints:self->background.constraints];
    self->background.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self->background.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self->twitter removeConstraints:self->twitter.constraints];
    self->twitter.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self->twitter.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self->tumblr removeConstraints:self->tumblr.constraints];
    self->tumblr.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self->tumblr.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self->facebook removeConstraints:self->facebook.constraints];
    self->facebook.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self->facebook.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self->snapchat removeConstraints:self->snapchat.constraints];
    self->snapchat.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self->snapchat.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self->youtube removeConstraints:self->youtube.constraints];
    self->youtube.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self->youtube.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self->instagram removeConstraints:self->instagram.constraints];
    self->instagram.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self->instagram.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self->reddit removeConstraints:self->reddit.constraints];
    self->reddit.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    self->reddit.translatesAutoresizingMaskIntoConstraints = YES;
    
    if( screenHeight > 480 && screenHeight < 667 ){
        
        NSLog(@"iPhone 5/5s");
        
        text.frame = CGRectMake(9, 72, 303, 206);
        background.frame = CGRectMake(0, 0, 320, 568);
        instagram.frame = CGRectMake(119, 349, 82, 82);
        facebook.frame = CGRectMake(170, 278, 71, 71);
        twitter.frame = CGRectMake(84, 278, 71, 71);
        snapchat.frame = CGRectMake(211, 354, 71, 71);
        youtube.frame = CGRectMake(38, 354, 71, 71);
        reddit.frame = CGRectMake(170, 431, 71, 71);
        tumblr.frame = CGRectMake(84, 431, 71, 71);
        
    } else if ( screenHeight > 480 && screenHeight < 736 ){
        
        NSLog(@"iPhone 6");
        
        text.frame = CGRectMake(20, 72, 335, 138);
        background.frame = CGRectMake(0, 0, 375, 667);
        instagram.frame = CGRectMake(140, 391, 95, 95);
        facebook.frame = CGRectMake(198, 308, 83, 83);
        twitter.frame = CGRectMake(98, 308, 83, 83);
        snapchat.frame = CGRectMake(247, 397, 83, 83);
        youtube.frame = CGRectMake(44, 397, 83, 83);
        tumblr.frame = CGRectMake(98, 487, 83, 83);
        reddit.frame = CGRectMake(198, 487, 83, 83);

    } else if ( screenHeight > 480 ){
        
        NSLog(@"iPhone 6 Plus");
        
        text.frame = CGRectMake(20, 72, 374, 252);
        background.frame = CGRectMake(0, 0, 414, 736);
        instagram.frame = CGRectMake(155, 412, 105, 105);
        facebook.frame = CGRectMake(219, 321, 93, 93);
        twitter.frame = CGRectMake(107, 321, 93, 93);
        snapchat.frame = CGRectMake(271, 418, 93, 93);
        youtube.frame = CGRectMake(49, 418, 93, 93);
        tumblr.frame = CGRectMake(107, 516, 93, 93);
        reddit.frame = CGRectMake(219, 516, 93, 93);

    } else {
        
        NSLog(@"iPhone 4/4s");
        
        text.frame = CGRectMake(9, 72, 303, 182);
        background.frame = CGRectMake(0, 0, 320, 568);
        instagram.frame = CGRectMake(119, 349, 82, 82);
        facebook.frame = CGRectMake(170, 278, 71, 71);
        twitter.frame = CGRectMake(84, 278, 71, 71);
        snapchat.frame = CGRectMake(211, 354, 71, 71);
        youtube.frame = CGRectMake(38, 354, 71, 71);
        reddit.frame = CGRectMake(170, 431, 71, 71);
        tumblr.frame = CGRectMake(84, 431, 71, 71);
        
    }
    
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
