//
//  NeedDetailViewController.h
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 26-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeedishNeed;

@interface NeedDetailViewController : UIViewController {
    IBOutlet UILabel *subjectLabel;
    IBOutlet UIWebView *textView;
    IBOutlet UILabel *ownerLabel;
    IBOutlet UILabel *statusLabel;
    IBOutlet UIImageView *ownerPicture;
    IBOutlet UIButton *helpsButton;
    
    NeedishNeed *need;
}
@property (nonatomic, retain) NeedishNeed *need;

- (IBAction)showOwnerDetail:(id)sender;
- (IBAction)showHelps:(id)sender;
- (IBAction)addNewHelp:(id)sender;

@end
