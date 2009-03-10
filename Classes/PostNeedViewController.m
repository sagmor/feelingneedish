//
//  PostNeedViewController.m
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 23-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import "PostNeedViewController.h"
#import "NeedishNeed.h"
#import "NeedishAPI.h"
#import "NeedDetailViewController.h"
#import "FeelingNeedishAppDelegate.h"

// static NSString *MFDetailPlaceHolder = @"Agregar Detalles";


@implementation PostNeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Nuevo Need";
	}
	return self;
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

- (IBAction)publish:(id)sender {
    MFDebug(@"Publishing Post!");
    FeelingNeedishAppDelegate *appDelegate = (FeelingNeedishAppDelegate *)[[UIApplication sharedApplication] delegate];

    NeedishNeed *newNeed = [[NeedishNeed alloc] init];
    newNeed.text = detailsTextField.text;
    
    NeedishNeed *resultNeed = [[appDelegate api] addNeed:newNeed];
    [newNeed release];

    if (resultNeed) {
		[[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Tu ayuda fue publicada" 
                                    delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];

        [[self navigationController] popViewControllerAnimated:YES];
    } else {
        [[[[UIAlertView alloc] initWithTitle:@"Error" message:@"No se pudo publicar tu ayuda" 
                                    delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
    }
}

@end
