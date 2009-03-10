//
//  Feeling_NeedishAppDelegate.m
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 22-09-08.
//  Copyright SagMor 2008. All rights reserved.
//

#import "FeelingNeedishAppDelegate.h"
#import "MainViewController.h"
#import "NeedishAPI.h"
#import "NeedishUser.h"
#import "NeedishNeed.h"


@implementation FeelingNeedishAppDelegate

@synthesize window;
@synthesize navigationController;


- (id)init {
	if (self = [super init]) {
		_defaultImages = [[NSArray alloc] initWithObjects:
                          [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"no_picture_0" ofType:@"png"]],
                          [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"no_picture_1" ofType:@"png"]],
                          [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"no_picture_2" ofType:@"png"]],
                          [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"no_picture_3" ofType:@"png"]],
                          [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"no_picture_4" ofType:@"png"]],
                          [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"no_picture" ofType:@"png"]],
                          nil];
	}
	return self;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}

- (NeedishAPI *)api {
    if (_api == nil) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        _api = [[NeedishAPI alloc] initWithAPIKey:NEEDISH_API_KEY 
                                  andAccountEmail:[userDefaults stringForKey:@"accountEmail"]
                                      andPassword:[userDefaults stringForKey:@"accountPassword"]];
    }
    
    return _api;
}

- (NeedishUser *)account {
    return [[self api] account];
}

- (UIImage *)imageForUser:(NeedishUser *)user {
    // NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSRange range = [[user pictureurl] rangeOfString:@"no_picture"];
    if ( range.location != NSNotFound ) {
        switch ([[user pictureurl]  characterAtIndex:(range.location + 12)]) {
            case '0':
                return [_defaultImages objectAtIndex:0];
            case '1':
                return [_defaultImages objectAtIndex:1];
            case '2':
                return [_defaultImages objectAtIndex:2];
            case '3':
                return [_defaultImages objectAtIndex:3];
            case '4':
                return [_defaultImages objectAtIndex:4];
            default:
                return [_defaultImages objectAtIndex:5];
        }  
    } else {
        // if ([userDefaults boolForKey:@"downloadAvatars"]) {
        //  TODO
        // }
        return [_defaultImages objectAtIndex:0];
    }
}

@end
