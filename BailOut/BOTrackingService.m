//
//  BOTrackingService.m
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOTrackingService.h"
#import "GA/GAI.h"

@interface BOTrackingService() {
    GAI *_gaiTracker;
}

@end

@implementation BOTrackingService

/**
 * Private initializer
 */
- (instancetype)_initPrivateTracker
{
    self = [super init];
    if (self) {
        [GAI sharedInstance].trackUncaughtExceptions = YES;
        [GAI sharedInstance].dispatchInterval = 10;
        _gaiTracker = [[GAI sharedInstance] trackerWithTrackingId:GOOGLE_ANALYTICS_ID];
    }
    return self;
}

/**
 * Disable init, force static initializer
 */
- (id)init
{
    [super doesNotRecognizeSelector:_cmd];
    return nil;
}

/*********** SHARED INSTANCE ************/
/****************************************/

+ (instancetype)sharedTracker
{
    static BOTrackingService *sharedTracker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTracker = [[self alloc] _initPrivateTracker];
    });
    return sharedTracker;
}

@end
