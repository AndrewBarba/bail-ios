//
//  BOConstants.h
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#ifndef BailOut_BOConstants_h
#define BailOut_BOConstants_h

#define GOOGLE_ANALYTICS_ID @"UA-43237008-1"

// Throws an exception if the current thread is not the main thread. This helps
// track down issues where UIKit calls are being made by helper threads.
#define BO_ASSERT_IS_MAIN_THREAD() if ([NSThread currentThread] != [NSThread mainThread]) @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@.%@ must be called on the main thread", NSStringFromClass([self class]), NSStringFromSelector(_cmd)] userInfo:nil];

#endif
