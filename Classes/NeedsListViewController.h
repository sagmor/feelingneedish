//
//  NeedsListViewController.h
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 25-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NeedishAPI, NeedishUser;


@interface NeedsListViewController : UITableViewController {
    NSArray *_needs;
    NeedishUser *_user;
    SEL _selector;
}

@property (nonatomic, retain) NSArray *needs;
@property (nonatomic, retain) NeedishUser *user;
@property (nonatomic) SEL selector;
- (void)showLoadingIndicator;
- (void)showReloadButton;
- (void)loadData:(NeedishAPI *)api;
@end
