//
//  ABDispatch.h
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABDispatch : NSObject

/**
 * Dispatches a block on the main thread
 */
void ABDispatchMain(void (^block)());

/**
 * Dispatches a block on a background thread
 */
void ABDispatchBackground(void (^block)());

/**
 * Dispatches a block on the main thread after a given number of seconds
 */
void ABDispatchAfter(float after, void (^block)());

/**
 * Macro used for running a block only once. 
 * Must use macro so the static token is dynamically compiled
 */
#define AB_DISPATCH_ONCE(block) static dispatch_once_t onceToken; dispatch_once(&onceToken, ^{ if (block) block(); });

@end
