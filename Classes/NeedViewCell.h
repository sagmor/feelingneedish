//
//  NeedCellViewController.h
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 25-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeedishNeed;

@interface NeedViewCell : UITableViewCell {
    NeedishNeed *need;
    
    IBOutlet UILabel *subjectLabel;
    IBOutlet UILabel *ownerLabel;
    IBOutlet UILabel *statusLabel;
    IBOutlet UIImageView *userAvatar;
}

@property (nonatomic, retain) NeedishNeed *need;

- (NeedViewCell *)initWithNeed:(NeedishNeed *)newNeed;

@end
