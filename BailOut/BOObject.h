//
//  BOObject.h
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOObject : NSObject

/**
 * Unique identifer for the object
 */
@property (nonatomic, strong, readonly) NSString *identifier;

/**
 * Date when object was created
 */
@property (nonatomic, strong, readonly) NSDate *createdAt;

/**
 * Date when object was last updated
 */
@property (nonatomic, strong, readonly) NSDate *updatedAt;

/**
 * Initializes object from backend dict
 */
- (id)initWithAPIDict:(NSDictionary *)dict;

@end
