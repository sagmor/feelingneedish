//
//  Need.m
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 25-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import "NeedishNeed.h"
#import "NeedishUser.h"

@implementation NeedishNeed

@synthesize needId = _needId;
@synthesize subject = _subject;
@synthesize text = _text;
@synthesize city = _city;
@synthesize status = _status;
@synthesize helpsCount = _helpsCount;
@synthesize created = _created;
@synthesize timediff = _timediff;
@synthesize owner = _owner;
// @synthesize helps = _helps;

- (NeedishNeed *)init {
    _api = nil;
    _needId = 0;
    _subject = nil;
    _text = nil;
    _city = nil;
    _helpsCount = 0;
    _created = 0;
    _timediff = 0;
    _status = local;
    
    return self;
}

+(NeedishNeed *)mock {
    NeedishNeed *mock = [[NeedishNeed alloc] init];
    
    mock.subject = @"Some Subject";
    mock.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    // mock.status = @"active";
    
    return [mock autorelease];
}

+(NSArray *)arrayOfMocks {
    NSMutableArray *mocks = [[NSMutableArray alloc] init];
    int i;
    for (i = 0; i < 5; i++) {
        [mocks addObject:[NeedishNeed mock]];
    }
    
    //NSArray *result = [NSArray arrayWithArray:mocks];
    //[mocks release];
    
    return [mocks autorelease];
}

@end
