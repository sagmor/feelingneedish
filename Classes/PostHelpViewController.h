//
//  PostHelpViewController.h
//  FeelingNeedish
//
//  Created by Sebastian Gamboa on 13-10-08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NeedishNeed;

@interface PostHelpViewController : UIViewController {
	NeedishNeed *need;
    IBOutlet UIButton *sendButton;
    IBOutlet UITextView *detailsTextField;
}
@property (nonatomic, retain) NeedishNeed *need;

- (IBAction)publish:(id)sender;

@end
