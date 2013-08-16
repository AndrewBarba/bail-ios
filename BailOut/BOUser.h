//
//  BOUser.h
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOObject.h"

@interface BOUser : BOObject

/**
 * Users phone number
 */
@property (nonatomic, strong, readonly) NSString *phoneNumber;

/**
 * Total number of bailouts for the user
 */
@property (nonatomic, strong, readonly) NSNumber *bailOuts;

@end
