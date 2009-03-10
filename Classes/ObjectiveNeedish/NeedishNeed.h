//
//  NeedishNeed.h
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 25-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NeedishObject.h"

@class NeedishUser;

typedef enum NeedishNeedStatus {
    local,
    active,
    unknown
} NeedishNeedStatus;


@interface NeedishNeed : NeedishObject {
    NSInteger _needId;
    
    NSString *_subject;
    NSString *_text;
    NSString *_city;
    
    NeedishNeedStatus _status;
    
    NSInteger _helpsCount;
    NSInteger _created;
    NSInteger _timediff;

    NeedishUser *_owner;
    NSArray *_helps;
}

@property (nonatomic, readonly) NSInteger needId;

@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *city;

@property (nonatomic, readonly) NeedishNeedStatus status;

@property (nonatomic, readonly) NSInteger helpsCount;
@property (nonatomic, readonly) NSInteger created;
@property (nonatomic, readonly) NSInteger timediff;

@property (nonatomic, retain) NeedishUser *owner;

+ (NeedishNeed *)mock;
+ (NSArray *)arrayOfMocks;
@end
