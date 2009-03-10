//
//  MainViewController.h
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 23-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController {
    IBOutlet UITableView *menuTableView;
    UIActivityIndicatorView *loadingIndicator;
}

@end
