//
//  PostHelpViewController.m
//  FeelingNeedish
//
//  Created by Sebastian Gamboa on 13-10-08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "PostHelpViewController.h"
#import "FeelingNeedishAppDelegate.h"
#import "NeedishHelp.h"
#import "NeedishAPI.h"



@implementation PostHelpViewController

@synthesize need;
/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

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

- (IBAction)publish:(id)sender {
	MFDebug(@"Publishing Help!");
    FeelingNeedishAppDelegate *appDelegate = (FeelingNeedishAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    NeedishHelp *newHelp = [[NeedishHelp alloc] init];
    newHelp.text = detailsTextField.text;
    
    NeedishHelp *resultHelp = [[appDelegate api] addHelp:newHelp toNeed:need];
    [newHelp release];
	
    if (resultHelp) {
		[[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Tu ayuda fue publicada" 
                                    delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
		
        [[self navigationController] popViewControllerAnimated:YES];
    } else {
        [[[[UIAlertView alloc] initWithTitle:@"Error" message:@"No se pudo publicar tu ayuda" 
                                    delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    }
}


@end
