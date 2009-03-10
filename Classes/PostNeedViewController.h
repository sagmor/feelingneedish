//
//  PostNeedViewController.h
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 23-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostNeedViewController : UIViewController {
    IBOutlet UIButton *publishButton;
	IBOutlet UITextField *subjectTextField;
    IBOutlet UITextView *detailsTextField;
}

- (IBAction)publish:(id)sender;

@end
