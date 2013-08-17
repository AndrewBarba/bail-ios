//
//  BORegistrationViewController.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BORegistrationViewController.h"
#import "BOAPIUserService.h"

@interface BORegistrationViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation BORegistrationViewController

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
    
    self.title = NSLocalizedString(@"Register", nil);
	
    [self.phoneNumberTextField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _endLoading];
    [self.phoneNumberTextField becomeFirstResponder];    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self _attemptRegister];
    return YES;
}

#pragma mark - Actions

- (IBAction)_handleRegisterTapped:(id)sender
{
    [self _attemptRegister];
}

#pragma mark - Register

- (void)_attemptRegister
{
    [self _startLoading];
    
    NSString *phoneNumber = self.phoneNumberTextField.text;
    
    [[BOAPIUserService sharedInstance] registerPhoneNumber:phoneNumber onCompletion:^(BOOL success, NSError *error){
        if (success) {
            [self performSegueWithIdentifier:@"Verify Segue" sender:self];
        } else {
            [self _endLoading];
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Invalid Phone Number", nil)
                                        message:NSLocalizedString(@"Please check the phone number you entered and try again. Don't forget the leading country code!", nil)
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
