//
//  NeedishAPI.h
//  FeelingNeedish
//
//  Created by Sebastian Gamboa on 04-10-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NeedishNeed, NeedishUser, NeedishHelp, SBJSON;

@interface NeedishAPI : NSObject {
    NSString *_apiKey;
    NSString *_accountEmail;
    NSString *_accountPassword;
    NeedishUser *_account;
    NSError *_error;
    SBJSON *_parser;
}

#pragma mark Properties
@property(nonatomic, readonly, copy) NSString *apiKey;
@property(nonatomic, readonly, copy) NSString *accountEmail;
@property(nonatomic, readonly, retain) NeedishUser *account;
@property(nonatomic, readonly, retain) NSError *error;

#pragma mark Initialization
-(NeedishAPI *)initWithAPIKey:(NSString *)apiKey andAccountEmail:(NSString *)accountEmail andPassword:(NSString *)accountPassword;

#pragma mark Users
- (NeedishUser *)authenticate;
- (NSArray *)friendsOfUser:(NeedishUser *)user withLimit:(NSInteger)limit inPage:(NSInteger)page;

#pragma mark Needs
- (NeedishNeed *)addNeed:(NeedishNeed *)need;
- (NSArray *)allNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page;
- (NSArray *)accountNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page;
- (NSArray *)friendsNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page;
- (NSArray *)followedNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page;
- (NSArray *)helpedNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page;
- (NSArray *)hotNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page;
- (NSArray *)needsSearch:(NSString *)query withLimit:(NSInteger)limit inPage:(NSInteger)page;
- (NSArray *)needsTagged:(NSString *)tag withLimit:(NSInteger)limit inPage:(NSInteger)page;
- (NSArray *)trackedNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page;
- (NSArray *)needsOfUser:(NeedishUser *)user withLimit:(NSInteger)limit inPage:(NSInteger)page;

#pragma mark Helps
- (NeedishHelp *)addHelp:(NeedishHelp *)help toNeed:(NeedishNeed *)need;
- (NSArray *)helpsOfNeed:(NeedishNeed *)need withLimit:(NSInteger)limit inPage:(NSInteger)page;

@end
