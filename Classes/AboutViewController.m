//
//  AboutViewController.m
//  FeelingNeedish
//
//  Created by Sebastian Gamboa on 01-10-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import "AboutViewController.h"


@implementation AboutViewController

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


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Acerca De";
    //[self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    //[aboutWebView loadData:[NSData ] MIMEType:<#(NSString *)MIMEType#> textEncodingName:<#(NSString *)textEncodingName#> baseURL:<#(NSURL *)baseURL#>];
    NSString *version  = [[[NSBundle mainBundle] infoDictionary] valueForKey:[NSString stringWithFormat:@"CFBundleVersion"]];
	[aboutWebView loadHTMLString:[NSString stringWithFormat:@"<font face=\"Helvetica\"> <p style=\"color:rgb(51,51,51); font-size: 55px;\"><br><br><b style=\"font-size:50px;\"><br>Feeling Needish</b><br>Version %@<br><br>"
                             "Interfaz de Needish para el iPhone/iPod Touch.<br><br>"
                             "Diseñada por <a href=\"mailto:sagmor@gmail.com?subject=Feeling Needish\">Sebastián Gamboa</a> para el Concurso <a href=\"http://www.web2rockstars.com/\">Web2.0Rockstars</a>.<br>"
                             "</p></font>",version] baseURL:nil];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	}
	return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
