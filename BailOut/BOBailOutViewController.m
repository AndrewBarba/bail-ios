//
//  BOBailOutViewController.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOBailOutViewController.h"
#import "BOAPIBailService.h"
#import "BOAPIUserService.h"

@interface BOBailOutViewController () <UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UIButton *bailOutButton;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation BOBailOutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = NSLocalizedString(@"Bail Me Out", nil);
}

#pragma mark - Actions

- (IBAction)_handeBailOutTapped:(id)sender
{
    [self _startLoading];
    [[BOAPIBailService sharedInstance] bailMeOut:0 onCompletion:^(BOOL success, NSError *error){
        if (success) {
            [self _prepareForCall];
            ABDispatchAfter(3.0, ^{
                [self _endLoading];
            });
        } else {
            [[BOAPIUserService sharedInstance] signOut:nil];
            [self _endLoading];
        }
    }];    
}

- (IBAction)_handeSettingsTapped:(id)sender
{
    [[[UIActionSheet alloc] initWithTitle:nil
                                 delegate:self
                        cancelButtonTitle:@"Cancel"
                   destructiveButtonTitle:nil
                        otherButtonTitles:@"Log Out", nil] showInView:self.view];
}

#pragma mark - Loading

- (void)_prepareForCall
{
    // do something
}

- (void)_startLoading
{
    self.bailOutButton.hidden = YES;
    self.spinner.hidden = NO;
    [self.spinner startAnimating];
}

- (void)_endLoading
{
    self.bailOutButton.hidden = NO;
    self.spinner.hidden = YES;
    [self.spinner stopAnimating];
}

#pragma mark - Action Sheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [[BOAPIUserService sharedInstance] signOut:nil];
    }
}

@end
