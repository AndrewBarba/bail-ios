//
//  BOViewController.h
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "GAITrackedViewController.h"

@interface BOViewController : GAITrackedViewController

/**
 * Common init that will be called whether initialized from nib, sotryboard or manually
 */
- (void)boCommonInit;

/**
 * Override method to for subscribing to nofifications
 * Guarenteed to only be called once
 */
- (void)registerForNotifictions;

/**
 * Override methods for unregistering notifications.
 * Called in dealloc
 */
- (void)unregisterForNotifications;

@end
