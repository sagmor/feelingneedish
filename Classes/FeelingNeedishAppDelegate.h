//
//  Feeling_NeedishAppDelegate.h
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 22-09-08.
//  Copyright SagMor 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeedishUser, NeedishAPI;

@interface FeelingNeedishAppDelegate : NSObject <UIApplicationDelegate> {
	
	IBOutlet UIWindow *window;
	IBOutlet UINavigationController *navigationController;
    NeedishAPI *_api;
    NSArray *_defaultImages;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@property (nonatomic, retain, readonly) NeedishUser *account;
@property (nonatomic, retain, readonly) NeedishAPI *api;

- (UIImage *)imageForUser:(NeedishUser *)user;

@end

