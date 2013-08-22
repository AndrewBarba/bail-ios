//
//  BOVerifyViewController.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOVerifyViewController.h"
#import "BOAPIUserService.h"
#import "BOKeychainService.h"

@interface BOVerifyViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *verifyTextField;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@end

@implementation BOVerifyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = NSLocalizedString(@"Verify Phone Number", nil);    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _endLoading];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.verifyTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

#pragma mark - Notifications

- (void)registerForNotifictions
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_handleAppOpenedWithVerifyCodeNotification:)
                                                 name:BOAppOpenedWithVerifyCodeNotificationKey
                                               object:nil];
}

- (void)unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:BOAppOpenedWithVerifyCodeNotificationKey
                                                  object:nil];
}

#pragma mark - Actions

- (IBAction)_handleVerifyTapped:(id)sender
{
    [self _attemptVerifyPhoneNumber:self.verifyTextField.text];
}

- (void)_handleAppOpenedWithVerifyCodeNotification:(NSNotification *)notification
{
    NSString *code = [notification object];
    [self.verifyTextField setText:code];
    [self _attemptVerifyPhoneNumber:code];
}

#pragma mark - Verify

- (void)_attemptVerifyPhoneNumber:(NSString *)code
{
    [self _startLoading];
    
    NSString *phoneNumber = [[BOKeychainService sharedInstance] phoneNumber];
    
    [[BOAPIUserService sharedInstance] verifyPhoneNumber:phoneNumber withCode:code onCompletion:^(BOOL success, NSError *error){
        if (success) {
            // this is handled automatically via NSNotification
        } else {
            [self _endLoading];
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Invalid Code", nil)
                                        message:NSLocalizedString(@"Please check the code you entered and try again. Feel free to go back to the registration screen and send yourself another code.", nil)
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Okay", nil)
                              otherButtonTitles:nil, nil] show];
        }
    }];
}

#pragma mark - Loading

- (void)_startLoading
{
    [self.spinner startAnimating];
    self.descriptionLabel.hidden = YES;
}

- (void)_endLoading
{
    [self.spinner stopAnimating];
    self.descriptionLabel.hidden = NO;
}

@end
