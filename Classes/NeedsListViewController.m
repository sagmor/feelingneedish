//
//  NeedsListViewController.m
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 25-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import "NeedsListViewController.h"
#import "NeedishNeed.h"
#import "NeedishAPI.h"
#import "NeedViewCell.h"
#import "NeedDetailViewController.h"
#import "FeelingNeedishAppDelegate.h"

@implementation NeedsListViewController

@synthesize needs = _needs;
@synthesize user = _user;
@synthesize selector = _selector;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
        [self setNeeds:[NSArray array]];
		_user = nil;
		_selector = 0;
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
    FeelingNeedishAppDelegate *appDelegate = (FeelingNeedishAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (_needs == nil) {
        [self showLoadingIndicator];
        if ([self respondsToSelector:@selector(loadData:)])
            [NSThread detachNewThreadSelector: @selector(loadData:) toTarget:self withObject:[appDelegate api]];
    }
}

- (void)showLoadingIndicator {
    CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithFrame:frame];
    [loading startAnimating];
    [loading sizeToFit];
    loading.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |
                                UIViewAutoresizingFlexibleRightMargin |
                                UIViewAutoresizingFlexibleTopMargin |
                                UIViewAutoresizingFlexibleBottomMargin);
    
    // initing the bar button
    UIBarButtonItem *loadingView = [[UIBarButtonItem alloc] initWithCustomView:loading];
    [loading release];
    loadingView.target = self;
    
    self.navigationItem.rightBarButtonItem = loadingView;
    [loadingView release];
}

- (void)showReloadButton {
    self.navigationItem.rightBarButtonItem = nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_needs)
        return [_needs count];
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NeedViewCell *needCell = [[[NSBundle mainBundle] loadNibNamed:@"NeedViewCell" owner:self options:nil] objectAtIndex:1];
    //needCell.need = [needs objectAtIndex:indexPath.row];
    [needCell setNeed:[_needs objectAtIndex:indexPath.row]];
    
    return needCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NeedDetailViewController *detailView = [[NeedDetailViewController alloc] initWithNibName:nil bundle:nil];
    detailView.view = [[[NSBundle mainBundle] loadNibNamed:@"NeedDetailViewController" owner:detailView options:nil] objectAtIndex:1];
    detailView.need = [_needs objectAtIndex:indexPath.row];
    
    [[self navigationController] pushViewController:detailView animated:YES];
    [detailView release];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
}
*/
/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
*/

- (void)loadData:(NeedishAPI *)api {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSArray *newNeeds = nil;
	
	if (_user != nil) {
		newNeeds = [api needsOfUser:_user withLimit:10 inPage:1];
	} else if (_selector != 0) {
		newNeeds = [api performSelector:_selector withObject:(id)10 withObject:(id)1];
	}
    
    if (newNeeds) {
        self.needs = newNeeds;
        [(UITableView *)self.view reloadData];
    } else {
        [[[[UIAlertView alloc] initWithTitle:@"Error" message:@"No se pudieron cargar los Needs" 
                                    delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
		[self showReloadButton];
        return;
    }
    
    [self showReloadButton];
    
	[pool release];
}


- (void)dealloc {
    [_needs release];
    [super dealloc];
}


@end

