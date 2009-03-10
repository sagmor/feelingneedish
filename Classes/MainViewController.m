//
//  MainViewController.m
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 23-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import "MainViewController.h"
#import "PostNeedViewController.h"
#import "NeedsListViewController.h"
#import "NeedishNeed.h"
#import "FeelingNeedishAppDelegate.h"
#import "AboutViewController.h"


@implementation MainViewController

/*
- (id)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
	}
	return self;
}
 */


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 7;
        case 1:
            return 1;
        default:
            return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame: CGRectZero reuseIdentifier:nil];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.text = @"Your Needs";
                break;
            case 1:
                cell.text = @"Post Need";
                break;
            case 2:
                cell.text = @"Friend's Needs";
                break;
            case 3:
                cell.text = @"Followed Needs";
                break;
            case 4:
                cell.text = @"Helped Needs";
                break;
            case 5:
                cell.text = @"Hot Needs";
                break;
            case 6:
                cell.text = @"Last Needs";
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        cell.text = @"Acerca de";
    }
	// Configure the cell
	return [cell autorelease];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == NSNotFound) 
        return;
    
    id nextView;
    
    // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                nextView = [[NeedsListViewController alloc] initWithNibName:@"NeedsListViewController" bundle:nil];
                [nextView setTitle:@"Your Needs"];
                [nextView setSelector:@selector(accountNeedsWithLimit:inPage:)];
                break;
            case 1:
                nextView = [[PostNeedViewController alloc] initWithNibName:@"PostNeedViewController" bundle:nil];
                break;
            case 2:
                nextView = [[NeedsListViewController alloc] initWithNibName:@"NeedsListViewController" bundle:nil];
                [nextView setTitle:@"Friend's Needs"];
                [nextView setSelector:@selector(friendsNeedsWithLimit:inPage:)];
                break;
            case 3:
                nextView = [[NeedsListViewController alloc] initWithNibName:@"NeedsListViewController" bundle:nil];
                [nextView setTitle:@"Followed Needs"];
                [nextView setSelector:@selector(followedNeedsWithLimit:inPage:)];
                break;
            case 4:
                nextView = [[NeedsListViewController alloc] initWithNibName:@"NeedsListViewController" bundle:nil];
                [nextView setTitle:@"Helped Needs"];
                [nextView setSelector:@selector(helpedNeedsWithLimit:inPage:)];
                break;
            case 5:
                nextView = [[NeedsListViewController alloc] initWithNibName:@"NeedsListViewController" bundle:nil];
                [nextView setTitle:@"Hot Needs"];
                [nextView setSelector:@selector(hotNeedsWithLimit:inPage:)];
                break;
            case 6:
                nextView = [[NeedsListViewController alloc] initWithNibName:@"NeedsListViewController" bundle:nil];
                [nextView setTitle:@"Last Needs"];
                [nextView setSelector:@selector(allNeedsWithLimit:inPage:)];
                break;
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        nextView = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    }
    
    [[self navigationController] pushViewController:nextView animated:YES];
    [nextView release];
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView 
         accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath 
{ 
    return UITableViewCellAccessoryDisclosureIndicator; 
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}



- (void)dealloc {
	[super dealloc];
}


- (void)viewDidLoad {
	[super viewDidLoad];
    loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    loadingIndicator.hidesWhenStopped = YES;
    [loadingIndicator stopAnimating];
    [self.view addSubview:loadingIndicator];
}


- (void)viewWillAppear:(BOOL)animated {
    // [menuTableView setBackgroundColor:[UIColor blueColor]];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.title = @"Menu";
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:YES animated:animated];
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


@end

