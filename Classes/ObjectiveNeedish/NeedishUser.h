//
//  NeedishUser.h
//  Feeling Needish
//
//  Created by Sebastian Gamboa on 25-09-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NeedishObject.h"


@interface NeedishUser : NeedishObject {
    NSInteger _userId;
    NSString *_name;
    NSString *_lastname;
    NSString *_nickname;
    NSString *_displayname;
    NSString *_biography;
    NSString *_pictureurl;
    NSString *_whyhelp;
    
    NSMutableArray *_needs;
}

@property (nonatomic, readonly) NSInteger userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lastname;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *displayname;
@property (nonatomic, copy) NSString *biography;
@property (nonatomic, copy) NSString *pictureurl;
@property (nonatomic, copy) NSString *whyhelp;
// @property (nonatomic, retain, readonly) NSArray *needs;

- (NSString *)fullName;

@end
