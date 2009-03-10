//
//  NeedDetailViewController.m
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 26-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import "NeedDetailViewController.h"
#import "NeedishNeed.h"
#import "NeedishUser.h"
#import "FeelingNeedishAppDelegate.h"
#import "PostHelpViewController.h"
#import "UserDetailsViewController.h"


@implementation NeedDetailViewController

- (NeedishNeed *)need {
    return need;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	}
	return YES;
}

- (void)setNeed:(NeedishNeed *)newNeed {
    FeelingNeedishAppDelegate *appDelegate = (FeelingNeedishAppDelegate *)[[UIApplication sharedApplication] delegate];    
    [newNeed retain];
    [need release];
    need = newNeed;
    
    if (need != nil) {
        subjectLabel.text = need.subject;
        // [textView setText: [need text]];
        
        [textView loadHTMLString:[NSString stringWithFormat:@"<div style=\" color:rgb(51,51,51); font-size: large; \"><p>%@</p></div>", 
                                  [[need text] stringByReplacingOccurrencesOfString:@"\n" 
                                                                         withString:@"</p><p>"]] 
                         baseURL:[NSURL URLWithString:@"http://needish.com/"]];

        if (need.owner != nil) {
            ownerLabel.text = [need.owner displayname];
            [ownerPicture setImage:[appDelegate imageForUser:[need owner]]];
        }
        else
            ownerLabel.text = @"";
    }
    
    [helpsButton setTitle:[NSString stringWithFormat:@"%d Helps", [need helpsCount]] forState:UIControlStateNormal];
}

// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        NeedishNeed *newNeed = [[NeedishNeed alloc] init];
        self.need = newNeed;
        [newNeed release];
        
        self.title = @"Detalles Need";

    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];

}

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

- (IBAction)showOwnerDetail:(id)sender {
	// UserDetailsViewController *userDetailsView = [[[NSBundle mainBundle] loadNibNamed:@"UserDetailsViewController" owner:self options:nil] objectAtIndex:1];
	UserDetailsViewController *userDetailsView = [[UserDetailsViewController alloc] initWithNibName:nil bundle:nil];
	userDetailsView.view = [[[NSBundle mainBundle] loadNibNamed:@"UserDetailsViewController" owner:userDetailsView options:nil] objectAtIndex:1];
    
	[userDetailsView setUser:[need owner]];
	[[self navigationController] pushViewController:userDetailsView animated:YES];
}

- (IBAction)showHelps:(id)sender {
}

- (IBAction)addNewHelp:(id)sender {
	PostHelpViewController *postView = [[PostHelpViewController alloc] initWithNibName:@"PostHelpViewController" bundle:nil];
	[postView setNeed:[self need]];
	[[self navigationController] pushViewController:postView animated:YES];
}


@end
