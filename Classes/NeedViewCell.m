//
//  NeedCellViewController.m
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 25-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//
#import "NeedViewCell.h"
#import "NeedishNeed.h"
#import "NeedishUser.h"
#import "FeelingNeedishAppDelegate.h"


@implementation NeedViewCell

- (void)setNeed:(NeedishNeed *)newNeed {
    FeelingNeedishAppDelegate *appDelegate = (FeelingNeedishAppDelegate *)[[UIApplication sharedApplication] delegate];    
    // MFDebug(@"NeedViewCell's need changed");
    
    [newNeed retain];
    [need release];
    need = newNeed;
    
    if (need != nil) {
        subjectLabel.text = need.subject;
        // statusLabel.text = need.status;
        if (need.owner != nil) {
            ownerLabel.text = [need.owner displayname];
            [userAvatar setImage:[appDelegate imageForUser:[need owner]]];
        }
        else
            ownerLabel.text = @"";
        
        
    }
}

- (NeedishNeed *)need {
    return need;
}

- (NeedViewCell *)initWithNeed:(NeedishNeed *)newNeed {
    if (self = [self initWithFrame:CGRectZero reuseIdentifier:nil]) {
        // [self addObserver:self forKeyPath:@"need" options:NSKeyValueObservingOptionNew context:NULL];
        self.need = [[NeedishNeed alloc] init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqual:@"need"]) {
        subjectLabel.text = need.subject;
        // statusLabel.text = need.status;
        if (need.owner)
            ownerLabel.text = [need.owner displayname];
        else
            ownerLabel.text = @"";
        
    }
    
}


@end
