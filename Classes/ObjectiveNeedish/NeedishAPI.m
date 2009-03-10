//
//  NeedishAPI.m
//  FeelingNeedish
//
//  Created by Sebastian Gamboa on 04-10-08.
//  Copyright 2008 SagMor. All rights reserved.
//

#import "NeedishAPI.h"

#import "base64/NSData+Base64.h"
#import "JSON/JSON.h"

#import "NeedishObject.h"
#import "NeedishUser.h"
#import "NeedishNeed.h"
#import "NeedishHelp.h"

#define HTTP_POST_METHOD        @"POST"
#define HTTP_GET_METHOD         @"GET"
#define NEEDISH_API_DOMAIN      @"api.needish.com"


@interface NeedishAPI(PrivateMethods)
- (NSMutableURLRequest *)requestToService:(NSString *)service withParams:(NSDictionary *)params usingHTTPMethod:(NSString *)method authenticated:(BOOL)authenticated;
- (NSDictionary *)performRequest:(NSURLRequest *)request;
- (NSString *)encodeString:(NSString *)string;
- (void)setError:(NSError *)error;
@end

@interface NeedishObject(APIPrivateMethods)
- (void)setAPI:(NeedishAPI *)api;
@end

@interface NeedishUser(APIPrivateMethods)
- (NeedishUser *)initWithDictionary:(NSDictionary *)dict andAPI:(NeedishAPI *)api;
@end

@interface NeedishNeed(APIPrivateMethods)
- (void)incrementHelps;
- (NeedishNeed *)initWithDictionary:(NSDictionary *)dict andAPI:(NeedishAPI *)api;
@end

@interface NeedishHelp(APIPrivateMethods)
- (NeedishHelp *)initWithDictionary:(NSDictionary *)dict andAPI:(NeedishAPI *)api;
@end

@implementation NeedishAPI

#pragma mark Properties

@synthesize apiKey = _apiKey;
@synthesize accountEmail = _accountEmail;
@synthesize error = _error;

- (NeedishUser *)account {
    if (_account == nil) {
        _account = [self authenticate];
    [_account retain];
    }

    return _account;
}

#pragma mark Initialization

-(NeedishAPI *)initWithAPIKey:(NSString *)apiKey andAccountEmail:(NSString *)accountEmail andPassword:(NSString *)accountPassword {
    _apiKey = [apiKey copy];
    _accountEmail = [accountEmail copy];
    _accountPassword = [accountPassword copy];
    
    _parser = [[SBJSON alloc] init];
    
    return self;
}

-(void)dealloc {
    [_parser release];
    [super dealloc];
}

#pragma mark Users
- (NeedishUser *)authenticate {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:nil];
    NSURLRequest *request = [self requestToService:@"/users/authenticate" withParams:params usingHTTPMethod:HTTP_POST_METHOD authenticated:YES];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NeedishUser *user = [[NeedishUser alloc] initWithDictionary:[[result objectForKey:@"user"] objectForKey:@"User"]
                                                         andAPI:self];
    
    return [user autorelease];
}

- (NSArray *)friendsOfUser:(NeedishUser *)user withLimit:(NSInteger)limit inPage:(NSInteger)page {
    return nil;
}


#pragma mark Needs
- (NeedishNeed *)addNeed:(NeedishNeed *)need {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [need subject], @"subject",
                            [need text], @"text", nil];
    NSMutableURLRequest *request = [self requestToService:@"/needs/add" withParams:params usingHTTPMethod:HTTP_POST_METHOD authenticated:YES];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NeedishNeed *resultNeed = (NeedishNeed *)[[NeedishNeed alloc] initWithDictionary:[[result objectForKey:@"need"] objectForKey:@"Need"] andAPI:self];
    [need setOwner:[self account]];
    
    return [resultNeed autorelease];
}

- (NSArray *)allNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                                [NSString stringWithFormat:@"%d", limit], @"limit",
                                                [NSString stringWithFormat:@"%d", page], @"page", nil];
    NSURLRequest *request = [self requestToService:@"/needs/all" withParams:params usingHTTPMethod:HTTP_GET_METHOD authenticated:NO];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NSMutableArray *needs = [[NSMutableArray alloc] init];
  
    for (id dict in [result objectForKey:@"needs"]) {
        NeedishNeed *need = (NeedishNeed *)[[NeedishNeed alloc] initWithDictionary:[dict objectForKey:@"Need"] andAPI:self];
        NeedishUser *user = [[NeedishUser alloc] initWithDictionary:[dict objectForKey:@"User"] andAPI:self];
        [need setOwner:user];
        [user release];
        [needs addObject:need];
    }
    
    return [needs autorelease];
}

- (NSArray *)accountNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page {
    return [self needsOfUser:[self account] withLimit:limit inPage:page];
}

- (NSArray *)friendsNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", limit], @"limit",
                            [NSString stringWithFormat:@"%d", page], @"page", nil];
    NSURLRequest *request = [self requestToService:@"/needs/friends" withParams:params usingHTTPMethod:HTTP_GET_METHOD authenticated:YES];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NSMutableArray *needs = [[NSMutableArray alloc] init];
    
    for (id dict in [result objectForKey:@"needs"]) {
        NeedishNeed *need = (NeedishNeed *)[[NeedishNeed alloc] initWithDictionary:[dict objectForKey:@"Need"] andAPI:self];
        NeedishUser *user = [[NeedishUser alloc] initWithDictionary:[dict objectForKey:@"User"] andAPI:self];
        [need setOwner:user];
        [user release];
        [needs addObject:need];
    }
    
    return [needs autorelease];
}

- (NSArray *)followedNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", limit], @"limit",
                            [NSString stringWithFormat:@"%d", page], @"page", nil];
    NSURLRequest *request = [self requestToService:@"/needs/follow" withParams:params usingHTTPMethod:HTTP_GET_METHOD authenticated:YES];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NSMutableArray *needs = [[NSMutableArray alloc] init];
    
    for (id dict in [result objectForKey:@"needs"]) {
        NeedishNeed *need = (NeedishNeed *)[[NeedishNeed alloc] initWithDictionary:[dict objectForKey:@"Need"] andAPI:self];
        NeedishUser *user = [[NeedishUser alloc] initWithDictionary:[dict objectForKey:@"User"] andAPI:self];
        [need setOwner:user];
        [user release];
        [needs addObject:need];
    }
    
    return [needs autorelease];
}

- (NSArray *)helpedNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", limit], @"limit",
                            [NSString stringWithFormat:@"%d", page], @"page", nil];
    NSURLRequest *request = [self requestToService:@"/needs/helped" withParams:params usingHTTPMethod:HTTP_GET_METHOD authenticated:YES];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NSMutableArray *needs = [[NSMutableArray alloc] init];
    
    for (id dict in [result objectForKey:@"needs"]) {
        NeedishNeed *need = (NeedishNeed *)[[NeedishNeed alloc] initWithDictionary:[dict objectForKey:@"Need"] andAPI:self];
        NeedishUser *user = [[NeedishUser alloc] initWithDictionary:[dict objectForKey:@"User"] andAPI:self];
        [need setOwner:user];
        [user release];
        [needs addObject:need];
    }
    
    return [needs autorelease];
}

- (NSArray *)hotNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", limit], @"limit",
                            [NSString stringWithFormat:@"%d", page], @"page", nil];
    NSURLRequest *request = [self requestToService:@"/needs/hot" withParams:params usingHTTPMethod:HTTP_GET_METHOD authenticated:YES];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NSMutableArray *needs = [[NSMutableArray alloc] init];
    
    for (id dict in [result objectForKey:@"needs"]) {
        NeedishNeed *need = (NeedishNeed *)[[NeedishNeed alloc] initWithDictionary:[dict objectForKey:@"Need"] andAPI:self];
        NeedishUser *user = [[NeedishUser alloc] initWithDictionary:[dict objectForKey:@"User"] andAPI:self];
        [need setOwner:user];
        [user release];
        [needs addObject:need];
    }
    
    return [needs autorelease];
}

- (NSArray *)needsSearch:(NSString *)query withLimit:(NSInteger)limit inPage:(NSInteger)page {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", limit], @"limit",
                            [NSString stringWithFormat:@"%d", page], @"page", nil];
    NSURLRequest *request = [self requestToService:[NSString stringWithFormat:@"/needs/search/%@",[self encodeString:query]]
                                        withParams:params usingHTTPMethod:HTTP_GET_METHOD authenticated:NO];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NSMutableArray *needs = [[NSMutableArray alloc] init];
    
    for (id dict in [result objectForKey:@"needs"]) {
        NeedishNeed *need = (NeedishNeed *)[[NeedishNeed alloc] initWithDictionary:[dict objectForKey:@"Need"] andAPI:self];
        NeedishUser *user = [[NeedishUser alloc] initWithDictionary:[dict objectForKey:@"User"] andAPI:self];
        [need setOwner:user];
        [user release];
        [needs addObject:need];
    }
    
    return [needs autorelease];
}

- (NSArray *)needsTagged:(NSString *)tag withLimit:(NSInteger)limit inPage:(NSInteger)page {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", limit], @"limit",
                            [NSString stringWithFormat:@"%d", page], @"page", nil];
    NSURLRequest *request = [self requestToService:[NSString stringWithFormat:@"/needs/tag/%@",[self encodeString:tag]]
                                        withParams:params usingHTTPMethod:HTTP_GET_METHOD authenticated:NO];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NSMutableArray *needs = [[NSMutableArray alloc] init];
    
    for (id dict in [result objectForKey:@"needs"]) {
        NeedishNeed *need = (NeedishNeed *)[[NeedishNeed alloc] initWithDictionary:[dict objectForKey:@"Need"] andAPI:self];
        NeedishUser *user = [[NeedishUser alloc] initWithDictionary:[dict objectForKey:@"User"] andAPI:self];
        [need setOwner:user];
        [user release];
        [needs addObject:need];
    }
    
    return [needs autorelease];
}

- (NSArray *)trackedNeedsWithLimit:(NSInteger)limit inPage:(NSInteger)page {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", limit], @"limit",
                            [NSString stringWithFormat:@"%d", page], @"page", nil];
    NSURLRequest *request = [self requestToService:@"/needs/tracker" withParams:params usingHTTPMethod:HTTP_GET_METHOD authenticated:YES];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NSMutableArray *needs = [[NSMutableArray alloc] init];
    
    for (id dict in [result objectForKey:@"needs"]) {
        NeedishNeed *need = (NeedishNeed *)[[NeedishNeed alloc] initWithDictionary:[dict objectForKey:@"Need"] andAPI:self];
        NeedishUser *user = [[NeedishUser alloc] initWithDictionary:[dict objectForKey:@"User"] andAPI:self];
        [need setOwner:user];
        [user release];
        [needs addObject:need];
		[need release];
    }
    
    return [needs autorelease];
}

- (NSArray *)needsOfUser:(NeedishUser *)user withLimit:(NSInteger)limit inPage:(NSInteger)page {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", limit], @"limit",
                            [NSString stringWithFormat:@"%d", page], @"page", nil];
    NSURLRequest *request = [self requestToService:[NSString stringWithFormat:@"/needs/user/%d",[user userId]]
                                        withParams:params usingHTTPMethod:HTTP_GET_METHOD authenticated:NO];    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NSMutableArray *needs = [[NSMutableArray alloc] init];
    
    for (id dict in [result objectForKey:@"needs"]) {
        NeedishNeed *need = (NeedishNeed *)[[NeedishNeed alloc] initWithDictionary:[dict objectForKey:@"Need"] andAPI:self];
        [need setOwner:user];
        [needs addObject:need];
    }
    
    return [needs autorelease];
}


#pragma mark Helps
- (NeedishHelp *)addHelp:(NeedishHelp *)help toNeed:(NeedishNeed *)need {
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [help text], @"text", nil];
    NSMutableURLRequest *request = [self requestToService: [NSString stringWithFormat:@"/helps/add/%d", [need needId]]
											   withParams:params usingHTTPMethod:HTTP_POST_METHOD authenticated:YES];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NeedishHelp *resultHelp = (NeedishHelp *)[[NeedishHelp alloc] initWithDictionary:[[result objectForKey:@"help"] objectForKey:@"Help"] andAPI:self];
    [resultHelp setNeed:need];
	[resultHelp setUser:[self account]];
	
	[need incrementHelps];
    
    return [resultHelp autorelease];
}

- (NSArray *)helpsOfNeed:(NeedishNeed *)need withLimit:(NSInteger)limit inPage:(NSInteger)page {
	NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%d", limit], @"limit",
                            [NSString stringWithFormat:@"%d", page], @"page", nil];
    NSURLRequest *request = [self requestToService:[NSString stringWithFormat:@"/needs/helps/%d",[need needId]]
                                        withParams:params usingHTTPMethod:HTTP_GET_METHOD authenticated:NO];    
    NSDictionary *result = [self performRequest:request];
    
    if (_error)
        return nil;
    
    NSMutableArray *helps = [[NSMutableArray alloc] init];
    
    for (id dict in [result objectForKey:@"helps"]) {
        NeedishHelp *help = (NeedishHelp *)[[NeedishHelp alloc] initWithDictionary:[dict objectForKey:@"Help"] andAPI:self];
		NeedishUser *user = [[NeedishUser alloc] initWithDictionary:[dict objectForKey:@"User"] andAPI:self];

        [help setNeed:need];
		[help setUser:user];
		[helps addObject:help];
		[help release];
		[user release];
    }
    
    return [helps autorelease];
}

#pragma mark PrivateMethods

- (NSMutableURLRequest *)requestToService:(NSString *)service withParams:(NSDictionary *)params usingHTTPMethod:(NSString *)method authenticated:(BOOL)authenticated {
    NSMutableString *postParams = [[NSMutableString alloc] initWithCapacity:50];
    [postParams appendFormat:@"app_key=%@", _apiKey];
    
    for (id key in [params allKeys]) {
        [postParams appendFormat:@"&%@=%@", (NSString *)key, [self encodeString:(NSString *)[params objectForKey:key]]];
    }
    
    NSURL *url = nil;
    NSMutableURLRequest *request = nil;
    if (method == HTTP_GET_METHOD) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@.json?%@", NEEDISH_API_DOMAIN, service, postParams]];
        request = [[NSMutableURLRequest alloc] initWithURL:url];
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@.json", NEEDISH_API_DOMAIN, service]];
        request = [[NSMutableURLRequest alloc] initWithURL:url];
        NSData *postData = [postParams dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:postData];
        [request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
    }
    [postParams release];
    [request setHTTPMethod:method];
    [request setTimeoutInterval:90.0];
    
    if (authenticated) {
        NSString *authStr = [NSString stringWithFormat:@"%@:%@", _accountEmail, _accountPassword];
		NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
		NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodingWithLineLength:80]];
		[request setValue:authValue forHTTPHeaderField:@"Authorization"];
    }

    return [request autorelease];
}

- (NSDictionary *)performRequest:(NSURLRequest *)request {
    NSURLResponse *response = nil;
    NSError *error = nil;
        
    NSData *theResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response 
                                                                error:&error];

    if (error) {
        [self setError:error];
        MFDebug(@"Request error: %@", [error localizedDescription]);
        return nil;
    }
    
    NSString *responseString = [[NSString alloc] initWithData:theResponseData encoding:NSUTF8StringEncoding];
	MFDebug(responseString);
    
    NSDictionary *dict = [_parser objectWithString:responseString error:&error];

    [responseString release];
    
    if (error) {
        [self setError:error];
        return nil;
    }
    
    if ([[dict objectForKey:@"rsp"] objectForKey:@"status"]) {
		[self setError:[[[NSError alloc] init] autorelease]];
        // do something
        // [dict release];
        return nil;
    }
    
    [self setError:nil];
    
    return [dict objectForKey:@"rsp"];
}

- (NSString *)encodeString:(NSString *)string
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, 
                                                                           (CFStringRef)string, 
                                                                           NULL, 
                                                                           (CFStringRef)@";/?:@&=$+{}<>,",
                                                                           kCFStringEncodingUTF8);
    return [result autorelease];
}

- (void)setError:(NSError *)error {
    [error retain];
    [_error release];
    _error = error;
}

@end

@implementation NeedishObject(APIPrivateMethods)
- (void)setAPI:(NeedishAPI *)api {
    [api retain];
    [_api release];
    _api = api;
}
@end

@implementation NeedishUser(APIPrivateMethods)
- (NeedishUser *)initWithDictionary:(NSDictionary *)dict andAPI:(NeedishAPI *)api {
    [self init];
    
    _api = api;
    
    _userId = [[dict valueForKey:@"id"] intValue];
	if ([dict valueForKey:@"name"] != [NSNull null])
		self.name = [dict valueForKey:@"name"];
	if ([dict valueForKey:@"lastname"] != [NSNull null])
		self.lastname = [dict valueForKey:@"lastname"];
	if ([dict valueForKey:@"nickname"] != [NSNull null])
		self.nickname = [dict valueForKey:@"nickname"];
    self.displayname = [dict valueForKey:@"displayname"];
	if ([dict valueForKey:@"biography"] != [NSNull null])
		self.biography = [dict valueForKey:@"biography"];
    self.pictureurl = [dict valueForKey:@"pictureurl"];
	if ([dict valueForKey:@"whyhelp"] != [NSNull null])
		self.whyhelp = [dict valueForKey:@"whyhelp"];
    
    return self;
}
@end

@implementation NeedishNeed(APIPrivateMethods)
- (NeedishNeed *)initWithDictionary:(NSDictionary *)dict andAPI:(NeedishAPI *)api {
    [self init];
    
    _api = api;
    
    _needId = [[dict objectForKey:@"id"] intValue];
    
    self.subject = [dict objectForKey:@"subject"];
    self.text = [dict objectForKey:@"text"];
    self.city = [dict objectForKey:@"city"];
    
    _helpsCount = [[dict objectForKey:@"helps"] intValue];
    _created = [[dict objectForKey:@"created"] intValue];
    _timediff = [[dict objectForKey:@"timediff"] intValue];
   
    NSString *status = [dict objectForKey:@"status"];
    
    if (status == @"active")
        _status = active;
    else
        _status = unknown;
    
    return self;
}

- (void)incrementHelps {
	_helpsCount++;
}
@end

@implementation NeedishHelp(APIPrivateMethods)
- (NeedishHelp *)initWithDictionary:(NSDictionary *)dict andAPI:(NeedishAPI *)api {
    [self init];
	
	_api = api;

	_helpId = [[dict objectForKey:@"id"] intValue];
    _created = [[dict objectForKey:@"created"] intValue];
    _timediff = [[dict objectForKey:@"timediff"] intValue];
    _stars = [[dict objectForKey:@"stars"] intValue];
    self.text = [dict objectForKey:@"text"];
	
    return self;
}
@end

