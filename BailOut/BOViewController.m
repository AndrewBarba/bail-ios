//
//  BOViewController.m
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOViewController.h"

@interface BOViewController () {
    BOOL _inited;
}

@end

@implementation BOViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self boCommonInit];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self boCommonInit];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self boCommonInit];
    }
    return self;
}

- (void)boCommonInit
{
    if (_inited) return;
    _inited = YES;
    
    [self registerForNotifictions];
}

- (void)dealloc
{
    [self unregisterForNotifications];
}

#pragma mark - Notifications

- (void)registerForNotifictions
{
    // override
}

- (void)unregisterForNotifications
{
    // override
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.trackedViewName = title;
}

@end
