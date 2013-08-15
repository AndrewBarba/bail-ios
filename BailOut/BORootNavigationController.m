//
//  BORootNavigationController.m
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BORootNavigationController.h"
#import "BOKeychainService.h"
#import "BOAPIRootService.h"

@interface BORootNavigationController ()

@end

@implementation BORootNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[BOKeychainService sharedInstance] setValue:@"12345" forKey:@"hello"];
    NSString *val = [[BOKeychainService sharedInstance] valueForKey:@"hello"];
    NSLog(@"Keychain: %@",val);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
