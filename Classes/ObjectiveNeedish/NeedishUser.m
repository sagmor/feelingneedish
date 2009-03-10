//
//  NeedishUser.m
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 25-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import "NeedishUser.h"

@implementation NeedishUser

@synthesize userId = _userId;
@synthesize name = _name;
@synthesize lastname = _lastname;
@synthesize nickname = _nickname;
@synthesize displayname = _displayname;
@synthesize biography = _biography;
@synthesize pictureurl = _pictureurl;
@synthesize whyhelp = _whyhelp;

- (NeedishUser *)init {
    _userId = 0;
    _name = nil;
    _lastname = nil;
    _nickname = nil;
    _displayname = nil;
    _biography = nil;
    _pictureurl = nil;
    _whyhelp = nil;
    
    _needs = nil;
    
    return self;
}

- (NSString *)fullName {
	return [NSString stringWithFormat:@"%@ %@", _name, _lastname];
}

@end
