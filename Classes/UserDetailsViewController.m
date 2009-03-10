//
//  UserDetailsViewController.m
//  FeelingNeedish
//
//  Created by Sebastian Gamboa on 14-10-08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "NeedishUser.h"
#import "FeelingNeedishAppDelegate.h"
#import "NeedsListViewController.h"

@implementation UserDetailsViewController

- (NeedishUser *)user {
	return user;
}

- (void)setUser:(NeedishUser *)newUser {
	if (user != newUser) {
		[newUser retain];
		[user release];
		user = newUser;
		
		[nickLabel setText:[user nickname]];
		[fullNameLabel setText:[user fullName]];
		[biographyTextView setText:[user biography]];
		[whyhelpTextView setText:[user whyhelp]];
		
		FeelingNeedishAppDelegate *appDelegate = (FeelingNeedishAppDelegate *)[[UIApplication sharedApplication] delegate]; 
		[pictureImageView setImage:[appDelegate imageForUser:user]];
		[self setTitle:[user displayname]];
	}
}

- (IBAction)showNeeds:(id)sender {
	NeedsListViewController *needsListView = [[NeedsListViewController alloc] initWithNibName:@"NeedsListViewController" bundle:nil];
	[needsListView setTitle:[NSString stringWithFormat:@"%@'s Needs", [user displayname]]];
	[needsListView setUser:user];
	[[self navigationController] pushViewController:needsListView animated:YES];
}

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
