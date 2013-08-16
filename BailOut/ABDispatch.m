//
//  ABDispatch.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "ABDispatch.h"

@implementation ABDispatch

void ABDispatchMain(void (^block)())
{
    dispatch_async(dispatch_get_main_queue(),block);
}

void ABDispatchAfter(float after, void (^block)())
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, after * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(),block);
}

void ABDispatchBackground(void (^block)())
{
    dispatch_queue_t queue = dispatch_queue_create("com.abarba.dispatchQueue", NULL);
    dispatch_async(queue,block);
}

@end
