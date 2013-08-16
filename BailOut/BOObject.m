//
//  BOObject.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOObject.h"

@implementation BOObject

- (id)initWithAPIDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _identifier = [dict[@"_id"] copy];
        
        NSTimeInterval createInterval = (NSTimeInterval)([dict[@"created_at"] integerValue] / 1000);
        _createdAt = [NSDate dateWithTimeIntervalSince1970:createInterval];
        
        NSTimeInterval updateInterval = (NSTimeInterval)([dict[@"update_at"] integerValue] / 1000);
        _updatedAt = [NSDate dateWithTimeIntervalSince1970:updateInterval];
    }
    return self;
}

- (id)init
{
    [super doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
