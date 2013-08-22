//
//  BORootNavigationController.m
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BORootNavigationController.h"
#import "BOKeychainService.h"

@interface BORootNavigationController ()

@end

@implementation BORootNavigationController

#pragma mark - Lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (![[BOKeychainService sharedInstance] hasAuth]) {
        [self presentViewController:[self _welcomeNavigationController] animated:NO completion:nil];
    }
}

// instantiates the welcome nav controller form the Main storyboard
- (UINavigationController *)_welcomeNavigationController
{
    UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *welcomeNav = [mainBoard instantiateViewControllerWithIdentifier:@"Welcome Navigation Controller"];
    return welcomeNav;
}

#pragma mark - Notifications

- (void)registerForNotifictions
{
    // sign in notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_handleSignInNotification:)
                                                 name:BOSignInNotificationKey
                                               object:nil];
    
    // sign out notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_handleSignOutNotification:)
                                                 name:BOSignOutNotificationKey
                                               object:nil];
}

- (void)unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BOSignInNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BOSignOutNotificationKey object:nil];
}

- (void)_handleSignInNotification:(NSNotification *)notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_handleSignOutNotification:(NSNotification *)notification
{
    [self presentViewController:[self _welcomeNavigationController] animated:YES completion:nil];
}

@end
