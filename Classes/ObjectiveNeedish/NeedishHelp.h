//
//  NeedishHelp.h
//  FeelingNeedish
//
//  Created by Sebastian Gamboa on 04-10-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NeedishObject.h"

@class NeedishNeed, NeedishUser;

@interface NeedishHelp : NeedishObject {
    NSInteger _helpId;
    NSInteger _created;
    NSInteger _timediff;
    NSInteger _stars;
    NSString *_text;
    
    NeedishNeed *_need;
    NeedishUser *_user;
}

@property (nonatomic, readonly) NSInteger helpId;
@property (nonatomic, readonly) NSInteger created;
@property (nonatomic, readonly) NSInteger timediff;
@property (nonatomic, readonly) NSInteger stars;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, retain) NeedishNeed *need;
@property (nonatomic, retain) NeedishUser *user;

@end
