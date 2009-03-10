//
//  UserDetailsViewController.h
//  FeelingNeedish
//
//  Created by Sebastian Gamboa on 14-10-08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NeedishUser;

@interface UserDetailsViewController : UIViewController {	
	IBOutlet UILabel *nickLabel;
	IBOutlet UILabel *fullNameLabel;
	IBOutlet UITextView *biographyTextView;
	IBOutlet UITextView *whyhelpTextView;
	IBOutlet UIImageView *pictureImageView;
	
	NeedishUser *user;
}

@property (nonatomic, retain) NeedishUser *user;

- (IBAction)showNeeds:(id)sender;

@end
