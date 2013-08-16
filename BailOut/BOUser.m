//
//  BOUser.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOUser.h"

@implementation BOUser

- (id)initWithAPIDict:(NSDictionary *)dict
{
    self = [super initWithAPIDict:dict];
    if (self) {
        _phoneNumber = [dict[@"phone_number"] copy];
        _bailOuts = @([dict[@"bail_outs"] integerValue]);
    }
    return self;
}

@end
