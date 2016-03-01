//
//  NavigationMenuTableViewController.m
//  TeamAppleNews
//
//  Created by Toby Woollaston on 18/07/2016.
//  Copyright © 2016 FutureAppleCEO. All rights reserved.
//

#import "NavigationMenuTableViewController.h"
#import "SWRevealViewController.h"
#import "SafariServices/SafariServices.h"

@interface NavigationMenuTableViewController ()

@end

@implementation NavigationMenuTableViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:NO];
    [self.revealViewController.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [self.revealViewController.frontViewController.view setUserInteractionEnabled:YES];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }
    }
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    switch ( indexPath.row )
    {
        case 0:
            CellIdentifier = @"blank";
            break;
            
        case 1:
            CellIdentifier = @"news";
            break;
            
        case 2:
            CellIdentifier = @"TAT";
            break;
            
        case 3:
            CellIdentifier = @"toys";
            break;
            
        case 4:
            CellIdentifier = @"bookmarks";
            break;
            
        case 5:
            CellIdentifier = @"events";
            break;
        
        case 6:
            CellIdentifier = @"gallery";
            break;
            
        case 7:
            CellIdentifier = @"website";
            break;
            
        case 8:
            CellIdentifier = @"connect";
            break;
            
        case 9:
            CellIdentifier = @"settings";
            break;
            
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
    
    if ( [segue isKindOfClass: [SWRevealViewController class]]) {
        
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            UINavigationController* navcController = (UINavigationController*)self.revealViewController.frontViewController;
            [navcController setViewControllers: @[dvc] animated:NO];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated:YES];
        };
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 6) {
        SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://instagram.com/futureappleceo/"]]];
        [self presentViewController:sfvc animated:YES completion:nil];
    }
    if (indexPath.row == 7) {
        SFSafariViewController *sfvc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.futureappleceo.com/"]]];
        [self presentViewController:sfvc animated:YES completion:nil];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
